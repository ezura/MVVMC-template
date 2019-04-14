//
//  String+Capitalize.swift
//  Files
//
//  Created by yuka ezura on 2019/04/14.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstLowercased: String {
        return prefix(1).lowercased() + dropFirst()
    }
}
