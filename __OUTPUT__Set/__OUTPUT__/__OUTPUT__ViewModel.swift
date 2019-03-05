//  
//  __OUTPUT__ViewModel.swift
//  mvvmc-template
//  
//  Created by yuka.ezura on 2019/03/05.
//  Copyright (c) Yuka Ezura 2019
//  

import Foundation
import Result
import RxCocoa
import RxSwift

protocol __OUTPUT__ViewModeling {
    var inputs: __OUTPUT__ViewModelInputs { get }
    var outputs: __OUTPUT__ViewModelOutputs { get }
    var coordinatorOutputs: __OUTPUT__ViewModelCoordinatorOutputs { get }
}

protocol __OUTPUT__ViewModelInputs {
}

protocol __OUTPUT__ViewModelOutputs {
}

protocol __OUTPUT__ViewModelCoordinatorOutputs {
}

final class __OUTPUT__ViewModel: __OUTPUT__ViewModelInputs, __OUTPUT__ViewModelOutputs, __OUTPUT__ViewModelCoordinatorOutputs, __OUTPUT__ViewModeling {

    var inputs: __OUTPUT__ViewModelInputs { return self }
    var outputs: __OUTPUT__ViewModelOutputs { return self }
    var coordinatorOutputs: __OUTPUT__ViewModelCoordinatorOutputs { return self }

    // MARK: - __OUTPUT__ViewModelInputs

    // MARK: - __OUTPUT__ViewModelOutputs

    // MARK: - __OUTPUT__ViewModelCoordinatorOutputs

    // MARK: -

    struct Dependency {
        let model: __OUTPUT__Modeling
    }

    private let dependency: Dependency
    private let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
