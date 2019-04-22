//
//  FirstTokenRewriter.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/04/20.
//

import Foundation
import SwiftSyntax

class FirstTokenRewriter: SyntaxRewriter {
    let rewrite: (TokenSyntax) -> TokenSyntax
    
    private var _isFirstToken = true
    
    init(rewrite: @escaping (TokenSyntax) -> TokenSyntax) {
        self.rewrite = rewrite
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        guard self._isFirstToken else {
            return super.visit(token)
        }
        
        self._isFirstToken = false
        let rewrittenToken = self.rewrite(token)
        
        return super.visit(rewrittenToken)
    }
}
