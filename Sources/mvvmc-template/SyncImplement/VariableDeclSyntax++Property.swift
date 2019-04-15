//
//  VariableDeclSyntax+Identifier.swift
//  Files
//
//  Created by yuka ezura on 2019/04/15.
//

import Foundation
import SwiftSyntax

extension VariableDeclSyntax {
    func havingSameName(with variableDecl: VariableDeclSyntax) -> Bool {
        return self.variableName == variableDecl.variableName
    }
    
    var variableName: String? {
        guard let binding = self.bindings.first(where: { $0.pattern is IdentifierPatternSyntax }),
            let pattern = binding.pattern as? IdentifierPatternSyntax else {
                return nil
        }
        return String(pattern.identifier.text
            .filter { !$0.isWhitespace }) // remove trivia
    }
}
