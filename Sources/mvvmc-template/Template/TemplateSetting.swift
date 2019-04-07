//
//  TemplateSetting.swift
//  Files
//
//  Created by yuka ezura on 2019/04/07.
//

import Foundation
import ShellOut

extension Template {
    enum Setting {
        case custom(baseName: String, copyright: String?, projectName: String?)
        
        var fileBaseName: String {
            switch self {
            case .custom(let baseName, _, _):
                return baseName
            }
        }
        
        var identifierName: String {
            switch self {
            case .custom(let baseName, _, _):
                return baseName
            }
        }
        
        func headerFor(typeName: String) -> String {
            switch self {
            case .custom(let baseName, let copyright, let projectName):
                let username = try? shellOut(to: "git config user.name")
                let date = try? shellOut(to: "date \"+%Y/%m/%d\"")
                return Template.headerTemplate(fileName: "\(baseName)\(typeName).swift",
                    projectName: projectName ?? "",
                    userName: username ?? "",
                    date: date ?? "",
                    copyright: copyright ?? "")
            }
        }
    }
}
