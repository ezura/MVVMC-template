//  
//  __OUTPUT__Model.swift
//  mvvmc-template
//  
//  Created by yuka.ezura on 2019/03/05.
//  Copyright (c) Yuka Ezura 2019
//  

import Foundation
import RxCocoa
import RxSwift

protocol __OUTPUT__Modeling {
    var inputs: __OUTPUT__ModelInputs { get }
    var outputs: __OUTPUT__ModelOutputs { get }
}

protocol __OUTPUT__ModelInputs {
}

protocol __OUTPUT__ModelOutputs {
}

final class __OUTPUT__Model: __OUTPUT__Modeling, __OUTPUT__ModelInputs, __OUTPUT__ModelOutputs {

    var inputs: __OUTPUT__ModelInputs { return self }
    var outputs: __OUTPUT__ModelOutputs { return self }

    // MARK: - __OUTPUT__ModelInputs

    // MARK: - __OUTPUT__ModelOutputs

    // MARK: -

    struct Dependency {
    }

    private let dependency: Dependency
    private let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
