//
//  CoordinatorTemplate.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension Template {
    static let coordinatorTemplate: (String) -> String = { name in
"""
import UIKit
import RxSwift
import RxCocoa

final class \(name)Coordinator: Coordinator<<#ResultType#>> {

    init() {
        <#initialize#>
    }

    override func start() -> Observable<CoordinationResult> {
        return <#Observable#>
    }
}
"""
    }
}
