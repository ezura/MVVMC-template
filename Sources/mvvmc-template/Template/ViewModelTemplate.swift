//
//  ViewModelTemplate.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension Template {
    static let viewModelTemplate: (String) -> String = { name in
"""
import Foundation
import Result
import RxCocoa
import RxSwift

protocol \(name)ViewModeling {
    var inputs: \(name)ViewModelInputs { get }
    var outputs: \(name)ViewModelOutputs { get }
    var coordinatorOutputs: \(name)ViewModelCoordinatorOutputs { get }
}

protocol \(name)ViewModelInputs {
}

protocol \(name)ViewModelOutputs {
}

protocol \(name)ViewModelCoordinatorOutputs {
}

final class \(name)ViewModel: \(name)ViewModelInputs, \(name)ViewModelOutputs, \(name)ViewModelCoordinatorOutputs, \(name)ViewModeling {

    var inputs: \(name)ViewModelInputs { return self }
    var outputs: \(name)ViewModelOutputs { return self }
    var coordinatorOutputs: \(name)ViewModelCoordinatorOutputs { return self }

    // MARK: - \(name)ViewModelInputs

    // MARK: - \(name)ViewModelOutputs

    // MARK: - \(name)ViewModelCoordinatorOutputs

    // MARK: -

    struct Dependency {
        let model: \(name)Modeling
    }

    private let dependency: Dependency
    private let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

"""
    }
}
