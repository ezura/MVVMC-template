//
//  Template+Role.swift
//  Files
//
//  Created by yuka ezura on 2019/04/14.
//

import Foundation

extension Template {
    enum Role {
        case model
        case viewModel(isConnectingWithCoordinator: Bool)
        case viewController
        case coordinator
        case coordinatorTests
    }
}

extension Template.Role: CaseIterable {
    static var allCases: [Template.Role] {
        return [.model,
                .viewModel(isConnectingWithCoordinator: true),
                .viewModel(isConnectingWithCoordinator: false),
                .viewController,
                .coordinator,
                .coordinatorTests]
    }
    
    var roleName: String {
        switch self {
        case .model:
            return "Model"
        case .viewModel:
            return "ViewModel"
        case .viewController:
            return "ViewController"
        case .coordinator:
            return "Coordinator"
        case .coordinatorTests:
            return "CoordinatorTests"
        }
    }
    
    func xcodeTemplatefileNameWith(baseName: String) -> String {
        switch self {
        case .model:
            return baseName + "Model.swift"
        case .viewModel:
            return baseName + "ViewModel.swift"
        case .viewController:
            return baseName + "ViewController.swift"
        case .coordinator:
            return baseName + "Coordinator.swift"
        case .coordinatorTests:
            return baseName + "CoordinatorTests.swift"
        }
    }
    
    func templateContent(name: String) -> String {
        switch self {
        case .model:
            return Template.modelTemplate(name)
        case .viewModel(let isConnectingWithCoordinator):
            let parentLayerName = isConnectingWithCoordinator ? "Coordinator" : "ParentLayer"
            return Template.viewModelTemplate(parentLayerName: parentLayerName)(name)
        case .viewController:
            return Template.viewControllerTemplate(name)
        case .coordinator:
            return Template.coordinatorTemplate(name)
        case .coordinatorTests:
            return Template.coordinatorTestsTemplate(name)
        }
    }
}
