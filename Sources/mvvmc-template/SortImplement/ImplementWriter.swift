//
//  ImplementWriter.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/03/31.
//

import Foundation
import SwiftSyntax

// TODO: create as module
extension ImplementWriter {
    
    struct Interface {
        let name: String
        /// store `VariableDeclSyntax` only (Thus ignore `FunctionDeclSyntax`)
        let memberVariables: [String]
        let position: AbsolutePosition
    }
    
    class InputOutputProtocolVisitor: SyntaxVisitor {
        var foundProtocols: [Interface] = []
        
        override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
            if node.identifier.text.hasSuffix("Inputs") || node.identifier.text.hasSuffix("Outputs") {
                foundProtocols.append(Interface(name: node.identifier.text,
                                                memberVariables: node.members.members.compactMap { ($0.decl as? VariableDeclSyntax)?.variableName },
                                                position: node.identifier.position))
            }
            return .skipChildren
        }
    }
    
    class ImplSectionRewriter: SyntaxRewriter {
        let interfaces: [Interface]
        let fileURL: URL
        
        init(interfaces: [Interface], fileURL: URL) {
            self.interfaces = interfaces
            self.fileURL = fileURL
        }
        
        // TODO: StructDeclSyntax
        override func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
            guard let inheritance = node.inheritanceClause?.inheritedTypeCollection
                .compactMap({ $0.typeName.description.trimmingCharacters(in: .whitespacesAndNewlines) }) else {
                return node
            }
            
            let targetInterfaces = interfaces.filter { inheritance.contains($0.name) }
            if targetInterfaces.isEmpty { return node }
            
            return targetInterfaces.reduce(node) { (result, interface) -> ClassDeclSyntax in
                grouping(for: interface, in: result)
            }
        }
        
        private func grouping(for targetInterface: Interface, in node: ClassDeclSyntax) -> ClassDeclSyntax {
            var sourceMembers = node.members.members
            var interfaceImplMembers: [MemberDeclListItemSyntax] = []
            var sectionHeaderMember: MemberDeclListItemSyntax? = nil
            var triviaPircesOfSectionComment: [TriviaPiece] = []
            
            for targetVariableName in targetInterface.memberVariables {
                guard let index = sourceMembers.firstIndex(where: { 
                    guard let originMember = $0.decl as? VariableDeclSyntax else { return false }
                    return originMember.variableName == targetVariableName
                }) else {
                    continue
                }
                
                let foundDecl = sourceMembers[index]
                let sectionCommentIndex = foundDecl.leadingTrivia?.firstIndex(where: { (piece) -> Bool in
                    return piece.comment?.contains("MARK: - \(targetInterface.name)") == true
                })
                
                if let sectionCommentIndex = sectionCommentIndex,
                    let leadingTrivia = foundDecl.leadingTrivia {
                    sectionHeaderMember = foundDecl
                    let startTriviasOfDeclIndex = leadingTrivia.dropFirst(sectionCommentIndex + 1)
                                                                .firstIndex { $0.isNewline }
                    let triviaPircesOfDecl: [TriviaPiece] = (startTriviasOfDeclIndex != nil) ? Array(leadingTrivia.dropFirst(startTriviasOfDeclIndex! + 1)) : []
                    triviaPircesOfSectionComment = (startTriviasOfDeclIndex != nil) ? Array(leadingTrivia.prefix(upTo: startTriviasOfDeclIndex!)) : leadingTrivia.map { $0 }
                    let trimedDecl = FirstTokenRewriter { token in 
                        token.withLeadingTrivia(Trivia.init(pieces: [.newlines(1)] + triviaPircesOfDecl))
                        }
                        .visit(foundDecl) as! MemberDeclListItemSyntax
                    interfaceImplMembers.append(trimedDecl)
                } else {
                    sourceMembers = sourceMembers.removing(childAt: index)
                    interfaceImplMembers.append(foundDecl)
                }
            }
            
            guard let _sectionHeaderMember = sectionHeaderMember,
                let sectionHeaderMemberIndex = sourceMembers.firstIndex(where: { 
                    ($0.decl as? VariableDeclSyntax)?.variableName == (_sectionHeaderMember.decl as? VariableDeclSyntax)?.variableName
                }) else {
                    print("\(fileURL.path):\(node.positionAfterSkippingLeadingTrivia.line):\(node.positionAfterSkippingLeadingTrivia.column): warning: section comment for `\(targetInterface.name)` is not found")
                    return node
            }
            
            // restore section header comment
            let headDecl = FirstTokenRewriter { (token) -> TokenSyntax in
                let originLeadingTrivia = token.leadingTrivia.map { $0 }
                return token.withLeadingTrivia(Trivia.init(pieces: triviaPircesOfSectionComment + originLeadingTrivia))
                }
                .visit(interfaceImplMembers.first!) as! MemberDeclListItemSyntax
            interfaceImplMembers[0] = headDecl
            
            sourceMembers = sourceMembers.removing(childAt: sectionHeaderMemberIndex)
            let formedMember = interfaceImplMembers.reversed().reduce(sourceMembers) { (result, member) in
                result.inserting(member, at: sectionHeaderMemberIndex)
            }
            let block = node.members.withMembers(formedMember)
            return node.withMembers(block)
        }
    }
}

class ImplementWriter {
    
    func sort(fileURL: URL) {
        let syntaxTree = try! SyntaxTreeParser.parse(fileURL)
        let protocolCollector = InputOutputProtocolVisitor()
        syntaxTree.walk(protocolCollector)
        
        let rewriter = ImplSectionRewriter(interfaces: protocolCollector.foundProtocols, fileURL: fileURL)
        let formedTree = rewriter.visit(syntaxTree)
        try! formedTree.description
            .write(to: fileURL, atomically: false, encoding: .utf8)
    }
}
