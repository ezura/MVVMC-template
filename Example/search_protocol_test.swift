import Foundation

protocol SampleInputs {
    var textDidEdit: BehaviorRelay<String?> { get }
    var okButtonDidTap: PublishRelay<Void> { get }
}

protocol SampleOutputs {
    var buttonTitle: Driver<String> { get }
    func f(a: Int)
}

class ViewController: SampleInputs, SampleOutputs {
    let okButtonDidTap: BehaviorRelay<Void> = PublishRelay()
    
    // MARK: - SampleInputs
    /// comment for `textDidEdit`
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // MARK: - SampleOutputs
    let buttonTitle: Driver<String>
}

class ViewController: SampleInputs, SampleOutputs where A: E {
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // MARK: - SampleInputs
    private let okButtonDidTap : BehaviorRelay<Void> = PublishRelay()
    
    // MARK: - SampleOutput
    let buttonTitle: Driver<String>
    
    struct  Dependency {
        let a: A
    }
    
    init() {
        print("init")
    }
    
    func f(a: Int) {
        print("")
    }
}
