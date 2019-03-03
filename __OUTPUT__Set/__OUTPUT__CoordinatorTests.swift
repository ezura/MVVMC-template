//  
//  __OUTPUT__CoordinatorTests.swift
//  mvvmc-template
//  
//  Created by ezura on 2019/03/03.
//  Copyright (c) Yuka Ezura 2019
//  

import XCTest
import UIKit
import RxSwift
@testable import <#your module name#>

final class __OUTPUT__CoordinatorTests: XCTestCase {

    private var disposeBag = DisposeBag()

    override func tearDown() {
        disposeBag = DisposeBag()
    }

    func testResolveDependencyOnStart() {
        let navigator = UINavigationController()
        let coordinator = __OUTPUT__Coordinator(<#args#>)
        coordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
