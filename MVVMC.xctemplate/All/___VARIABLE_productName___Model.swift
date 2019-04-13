//___FILEHEADER___

import Foundation
import RxCocoa
import RxSwift

protocol ___VARIABLE_productName___Modeling {
    var inputs: ___VARIABLE_productName___ModelInputs { get }
    var outputs: ___VARIABLE_productName___ModelOutputs { get }
}

protocol ___VARIABLE_productName___ModelInputs {
}

protocol ___VARIABLE_productName___ModelOutputs {
}

final class ___VARIABLE_productName___Model: ___VARIABLE_productName___Modeling, ___VARIABLE_productName___ModelInputs, ___VARIABLE_productName___ModelOutputs {

    var inputs: ___VARIABLE_productName___ModelInputs { return self }
    var outputs: ___VARIABLE_productName___ModelOutputs { return self }

    // MARK: - ___VARIABLE_productName___ModelInputs

    // MARK: - ___VARIABLE_productName___ModelOutputs

    // MARK: -

    struct Dependency {
    }

    private let dependency: Dependency
    private let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
