//
//  ProtocolDeclSyntax+Property.swift
//  Files
//
//  Created by yuka ezura on 2019/04/15.
//

import Foundation
import SwiftSyntax

extension ProtocolDeclSyntax {
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
