//
//  TriviaPiece+Propert.swift
//  Files
//
//  Created by yuka ezura on 2019/04/16.
//

import Foundation
import SwiftSyntax

extension TriviaPiece {
    var comment: String? {
        switch self {
        case .spaces,
             .tabs,
             .verticalTabs,
             .formfeeds,
             .newlines,
             .carriageReturns,
             .carriageReturnLineFeeds,
             .backticks,
             .garbageText:
            return nil
        case .lineComment(let comment),
             .blockComment(let comment),
             .docLineComment(let comment),
             .docBlockComment(let comment):
            return comment
        }
    }
    
    var isNewline: Bool {
        switch self {
        case .newlines: 
            return true
        default:
            return false
        }
    }
}
