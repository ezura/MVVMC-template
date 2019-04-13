//___FILEHEADER___

import XCTest
import UIKit
import RxSwift
@testable import <#your module name#>

final class ___VARIABLE_productName___CoordinatorTests: XCTestCase {

    private var disposeBag = DisposeBag()

    override func tearDown() {
        disposeBag = DisposeBag()
    }

    func testResolveDependencyOnStart() {
        let navigator = UINavigationController()
        let coordinator = ___VARIABLE_productName___Coordinator(<#args#>)
        coordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
