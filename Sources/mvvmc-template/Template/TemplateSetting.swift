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
        case xcodeTemplate
    }
}
