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
}

final class \(name)Model: \(name)Modeling {
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
