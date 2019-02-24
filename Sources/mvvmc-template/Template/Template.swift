//
//  Template.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

enum Template {
    case `default`(name: String)

    var model: String {
        switch self {
        case .default(name: let name):
            return Template.modelTemplate(name)
        }
    }

    var viewController: String {
        switch self {
        case .default(name: let name):
            return Template.viewControllerTemplate(name)
        }
    }

    var viewModel: String {
        switch self {
        case .default(name: let name):
            return Template.viewModelTemplate(name)
        }
    }

    var coordinator: String {
        switch self {
        case .default(name: let name):
            return Template.coordinatorTemplate(name)
        }
    }

    var coordinatorTests: String {
        switch self {
        case .default(name: let name):
            return Template.coordinatorTestsTemplate(name)
        }
    }
}
