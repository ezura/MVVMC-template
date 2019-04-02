import Foundation

protocol SampleInputs {
    var okButtonDidTap: PublishRelay<Void> { get }
    var textDidEdit: BehaviorRelay<String?> { get }
}

protocol SampleOutputs {
    var buttonTitle: Driver<String> { get }
}

class ViewController: SampleInputs, SampleOutputs {
    
    // SampleInput
    let okButtonDidTap: BehaviorRelay<Void> = PublishRelay()
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // SampleOutput
    let buttonTitle: Driver<String>
}
