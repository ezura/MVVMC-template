//
//  ModelTemplate.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension Template {
    static let modelTemplate: (String) -> String = { name in
"""
import Foundation
import RxCocoa
import RxSwift

protocol \(name)Modeling {
    var inputs: \(name)ModelInputs { get }
    var outputs: \(name)ModelOutputs { get }
}

protocol \(name)ModelInputs {
}

protocol \(name)ModelOutputs {
}

final class \(name)Model: \(name)Modeling, \(name)ModelInputs, \(name)ModelOutputs {

    var inputs: \(name)ModelInputs { return self }
    var outputs: \(name)ModelOutputs { return self }

    // MARK: - \(name)ModelInputs

    // MARK: - \(name)ModelOutputs

    // MARK: -

    struct Dependency {
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
