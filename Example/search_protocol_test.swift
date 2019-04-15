import Foundation

protocol SampleInputs {
    var okButtonDidTap: PublishRelay<Void> { get }
    var textDidEdit: BehaviorRelay<String?> { get }
}

protocol SampleOutputs {
    var buttonTitle: Driver<String> { get }
    func f(a: Int)
}

class ViewController: SampleInputs, SampleOutputs {
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // MARK: SampleInputs
    let okButtonDidTap: BehaviorRelay<Void> = PublishRelay()
    
    // MARK: SampleOutputs
    let buttonTitle: Driver<String>
}

class ViewController: SampleInputs, SampleOutputs where A: E {
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // MARK: SampleInputs
    private let okButtonDidTap : BehaviorRelay<Void> = PublishRelay()
    
    // MARK: SampleOutputs
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
