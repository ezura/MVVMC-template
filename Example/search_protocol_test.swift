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
    
    // SampleInput
    let okButtonDidTap: BehaviorRelay<Void> = PublishRelay()
    
    // SampleOutput
    let buttonTitle: Driver<String>
}

struct ViewController: SampleInputs, SampleOutputs where A: E {
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // SampleInput
    private let okButtonDidTap : BehaviorRelay<Void> = PublishRelay()
    
    // SampleOutput
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

