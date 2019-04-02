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
            if node.identifier.text.hasSuffix("Inputs") {
                print("// MARK: - \(node.identifier.text)")
                node.extractVariableDecl().forEach { (pattern, typeAnnotation) in
                    print("let \(pattern.identifier): \(typeAnnotation.type)") // TODO: append initializer
                }
                print()
            } else if  node.identifier.text.hasSuffix("Outputs") {
                print("// MARK: - \(node.identifier.text)")
                node.extractVariableDecl().forEach { (pattern, typeAnnotation) in
                    print("let \(pattern.identifier): \(typeAnnotation.type)")
                }
                print()
            }
        }
        sourceFile.walk(visitor)
    }
}

private extension ProtocolDeclSyntax {
    func extractVariableDecl() -> [(IdentifierPatternSyntax, TypeAnnotationSyntax)] {
        return self.members.members.compactMap { declMember in
            guard let varDecl = declMember.decl as? VariableDeclSyntax,
                let binding = varDecl.bindings.first(where: { $0.pattern is IdentifierPatternSyntax }),
                let pattern = binding.pattern as? IdentifierPatternSyntax,
                let typeAnnotation = binding.typeAnnotation else { return nil }
            return (pattern, typeAnnotation)
        }
    }
}
