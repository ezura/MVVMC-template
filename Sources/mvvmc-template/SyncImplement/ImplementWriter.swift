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
    }
    
    class InputOutputProtocolVisitor: SyntaxVisitor {
        var foundProtocols: [Interface] = []
        
        override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
            if node.identifier.text.hasSuffix("Inputs") || node.identifier.text.hasSuffix("Outputs") {
                foundProtocols.append(Interface(name: node.identifier.text,
                                                memberVariables: node.members.members.compactMap { ($0.decl as? VariableDeclSyntax)?.variableName }))
            }
            return .skipChildren
        }
    }
    
    class ImplSectionRewriter: SyntaxRewriter {
        let interfaces: [Interface]
        
        init(interfaces: [Interface]) {
            self.interfaces = interfaces
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
            var removedMember: [MemberDeclListItemSyntax] = []
            var sectionHeaderMember: MemberDeclListItemSyntax? = nil
            for targetVariableName in targetInterface.memberVariables {
                guard let index = sourceMembers.firstIndex(where: { 
                    guard let originMember = $0.decl as? VariableDeclSyntax else { return false }
                    return originMember.variableName == targetVariableName
                }) else {
                    continue
                }
                
                let foundDecl = sourceMembers[index]
                let hasTargetSectionComment = foundDecl.leadingTrivia?.contains(where: { (piece) -> Bool in
                    switch piece {
                    case .spaces,
                         .tabs,
                         .verticalTabs,
                         .formfeeds,
                         .newlines,
                         .carriageReturns,
                         .carriageReturnLineFeeds,
                         .backticks,
                         .garbageText:
                        return false
                    case .lineComment(let comment),
                         .blockComment(let comment),
                         .docLineComment(let comment),
                         .docBlockComment(let comment):
                        return comment.contains("MARK: \(targetInterface.name)")
                    }
                })
                
                if hasTargetSectionComment == true {
                    sectionHeaderMember = foundDecl
                } else {
                    removedMember.append(foundDecl)
                    sourceMembers = sourceMembers.removing(childAt: index)
                }
            }
            
            guard let _sectionHeaderMember = sectionHeaderMember,
                let sectionHeaderMemberIndex = sourceMembers.firstIndex(where: { 
                    ($0.decl as? VariableDeclSyntax)?.variableName == (_sectionHeaderMember.decl as? VariableDeclSyntax)?.variableName
                }) else {
                    print("\(targetInterface.name): Section comment is not found")
                    return node
            }
            let formedMember = removedMember.reversed().reduce(sourceMembers) { (result, member) in
                result.inserting(member, at: sectionHeaderMemberIndex + 1)
            }
            let block = node.members.withMembers(formedMember)
            return node.withMembers(block)
        }
    }
}

class ImplementWriter: SyntaxRewriter {
    
    func grouping(fileURL: URL) {
        let syntaxTree = try! SyntaxTreeParser.parse(fileURL)
        let protocolCollector = InputOutputProtocolVisitor()
        syntaxTree.walk(protocolCollector)
        
        let rewriter = ImplSectionRewriter(interfaces: protocolCollector.foundProtocols)
        print(rewriter.visit(syntaxTree).description)
    }
}
