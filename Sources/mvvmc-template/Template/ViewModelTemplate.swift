//
//  ViewModelTemplate.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension Template {
    static func viewModelTemplate(parentLayerName: String) -> (String) -> String {
        let parentLayerNameUppercaesd = parentLayerName.firstUppercased
        let parentLayerNameCapitalized = parentLayerName.firstLowercased
        return { name in
"""
import Foundation
import Result
import RxCocoa
import RxSwift

protocol \(name)ViewModeling {
    var inputs: \(name)ViewModelInputs { get }
    var outputs: \(name)ViewModelOutputs { get }
    var \(parentLayerNameCapitalized)Outputs: \(name)ViewModel\(parentLayerNameUppercaesd)Outputs { get }
}

protocol \(name)ViewModelInputs {
}

protocol \(name)ViewModelOutputs {
}

protocol \(name)ViewModel\(parentLayerNameUppercaesd)Outputs {
}

final class \(name)ViewModel: \(name)ViewModelInputs, \(name)ViewModelOutputs, \(name)ViewModel\(parentLayerNameUppercaesd)Outputs, \(name)ViewModeling {

    var inputs: \(name)ViewModelInputs { return self }
    var outputs: \(name)ViewModelOutputs { return self }
    var \(parentLayerNameCapitalized)Outputs: \(name)ViewModel\(parentLayerNameUppercaesd)Outputs { return self }

    // MARK: - \(name)ViewModelInputs

    // MARK: - \(name)ViewModelOutputs

    // MARK: - \(name)ViewModel\(parentLayerNameUppercaesd)Outputs

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
}
