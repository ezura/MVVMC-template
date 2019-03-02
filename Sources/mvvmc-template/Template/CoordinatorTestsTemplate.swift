//
//  CoordinatorTestsTemplate.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension Template {
    static let coordinatorTestsTemplate: (String) -> String = { name in
"""
import XCTest
import UIKit
import RxSwift
@testable import <#your module name#>

final class \(name)CoordinatorTests: XCTestCase {

    private var disposeBag = DisposeBag()

    override func tearDown() {
        disposeBag = DisposeBag()
    }

    func testResolveDependencyOnStart() {
        let navigator = UINavigationController()
        let coordinator = \(name)Coordinator(<#args#>)
        coordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
 
"""
    }
}
