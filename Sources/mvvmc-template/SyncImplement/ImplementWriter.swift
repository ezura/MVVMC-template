//
//  ImplementWriter.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/03/31.
//

import Foundation
import SwiftSyntax

extension ImplementWriter {
    class ProtocolVisitor: SyntaxVisitor {
        var onFind: (ProtocolDeclSyntax) -> Void
        
        init(onFind: @escaping (ProtocolDeclSyntax) -> Void) {
            self.onFind = onFind
        }
        
        override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
            onFind(node)
            return .skipChildren
        }
    }
}

class ImplementWriter: SyntaxRewriter {
    
    func printImplementation(fileURL: URL) {
        let sourceFile = try! SyntaxTreeParser.parse(fileURL)
        let visitor = ProtocolVisitor { node in
            if node.identifier.text.hasSuffix("Input") {
                // TODO: 
            } else if  node.identifier.text.hasSuffix("Output") {
                print("// \(node.identifier.text)")
                node.members.members.forEach { declMember in
                    guard let varDecl = declMember.decl as? VariableDeclSyntax else { return }
                    guard let binding = varDecl.bindings.first(where: { $0.pattern is IdentifierPatternSyntax }),
                    let pattern = binding.pattern as? IdentifierPatternSyntax,
                    let typeAnnotation = binding.typeAnnotation else { return }
                    print("let", pattern.identifier, typeAnnotation.type)
                }
                print()
            }
        }
        sourceFile.walk(visitor)
    }
}
