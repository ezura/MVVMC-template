import Foundation

protocol SampleInput {
    var okButtonDidTap: PublishRelay<Void> { get }
    var textDidEdit: BehaviorRelay<String?> { get }
}

protocol SampleOutput {
    var buttonTitle: Driver<String> { get }
}

class ViewController: SampleInput {
    
    // SampleInput
    let okButtonDidTap: BehaviorRelay<Void> = PublishRelay()
    let textDidEdit: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // SampleOutput
    let buttonTitle: Driver<String>
}
