//___FILEHEADER___

import Foundation
import Result
import RxCocoa
import RxSwift

protocol ___VARIABLE_productName___ViewModeling {
    var inputs: ___VARIABLE_productName___ViewModelInputs { get }
    var outputs: ___VARIABLE_productName___ViewModelOutputs { get }
    var parentLayerOutputs: ___VARIABLE_productName___ViewModelParentLayerOutputs { get }
}

protocol ___VARIABLE_productName___ViewModelInputs {
}

protocol ___VARIABLE_productName___ViewModelOutputs {
}

protocol ___VARIABLE_productName___ViewModelParentLayerOutputs {
}

final class ___VARIABLE_productName___ViewModel: ___VARIABLE_productName___ViewModelInputs, ___VARIABLE_productName___ViewModelOutputs, ___VARIABLE_productName___ViewModelParentLayerOutputs, ___VARIABLE_productName___ViewModeling {

    var inputs: ___VARIABLE_productName___ViewModelInputs { return self }
    var outputs: ___VARIABLE_productName___ViewModelOutputs { return self }
    var parentLayerOutputs: ___VARIABLE_productName___ViewModelParentLayerOutputs { return self }

    // MARK: - ___VARIABLE_productName___ViewModelInputs

    // MARK: - ___VARIABLE_productName___ViewModelOutputs

    // MARK: - ___VARIABLE_productName___ViewModelParentLayerOutputs

    // MARK: -

    struct Dependency {
        let model: ___VARIABLE_productName___Modeling
    }

    private let dependency: Dependency
    private let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
