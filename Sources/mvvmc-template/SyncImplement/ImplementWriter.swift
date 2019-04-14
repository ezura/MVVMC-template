//
//  ImplementWriter.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/03/31.
//

import Foundation
import SwiftSyntax

extension ImplementWriter {
    enum InputOutputProtocol {
        case input(ProtocolDeclSyntax)
        case output(ProtocolDeclSyntax)
    }
    
    class InputOutputProtocolVisitor: SyntaxVisitor {
        var onFind: (InputOutputProtocol) -> Void
        
        init(onFind: @escaping (InputOutputProtocol) -> Void) {
            self.onFind = onFind
        }
        
        override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
            if node.identifier.text.hasSuffix("Inputs") {
                onFind(.input(node))
            } else if  node.identifier.text.hasSuffix("Outputs") {
                onFind(.output(node))
            }
            return .skipChildren
        }
    }
}

class ImplementWriter: SyntaxRewriter {
    
    func printImplementation(fileURL: URL) {
        let sourceFile = try! SyntaxTreeParser.parse(fileURL)
        let visitor = InputOutputProtocolVisitor { foundProtocol in
            switch foundProtocol {
            case .input(let node):
                print("// MARK: - \(node.identifier.text)")
                node.extractVariableDecl().forEach { (pattern, typeAnnotation) in
                    print("let \(pattern.identifier): \(typeAnnotation.type)")
                }
                print()
            case .output(let node):
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
