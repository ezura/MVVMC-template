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

protocol \(name)Inputs {
}

protocol \(name)Outputs {
}

protocol \(name)CoordinatorOutputs {
}

protocol \(name)ViewModeing {
    var inputs: \(name)Inputs { get }
    var outputs: \(name)Outputs { get }
    var coordinatorOutputs: \(name)CoordinatorOutputs { get }
}

final class \(name): \(name)Inputs, \(name)Outputs, \(name)CoordinatorOutputs, \(name)ViewModeing {

    var inputs: \(name)Inputs { return self }
    var outputs: \(name)Outputs { return self }
    var coordinatorOutputs: \(name)CoordinatorOutputs { return self }

    // MARK: - \(name)Inputs

    // MARK: - \(name)Outputs

    // MARK: - \(name)CoordinatorOutputs

    // MARK: -

    struct Dependency {
        let model: \(name)Model
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
