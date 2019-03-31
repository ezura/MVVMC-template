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
        struct VisitResult {
            var inputs: [ProtocolDeclSyntax]
            var outputs: [ProtocolDeclSyntax]
        }
        
        private(set) var visitResult: VisitResult?
        
        override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
            if node.identifier.text.hasSuffix("Input") {
                visitResult?.inputs.append(node)
                return .skipChildren
            } else if  node.identifier.text.hasSuffix("Output") {
                visitResult?.outputs.append(node)
                return .skipChildren
            } else {
                return .skipChildren
            }
        }
    }
}

class ImplementWriter: SyntaxRewriter {
    
    private var inputProtocolTree: Syntax?
    
    func scan(filePath: String) {
        let url = URL(fileURLWithPath: "../Example/interface.swift")
        let sourceFile = try! SyntaxTreeParser.parse(url)
        let visitor = ProtocolVisitor()
        sourceFile.walk(visitor)
    }
}
