//___FILEHEADER___

import UIKit
import RxSwift
import RxCocoa

final class ___VARIABLE_productName___ViewController: UIViewController {

    private let viewModel: ___VARIABLE_productName___ViewModeling
    private let disposeBag = DisposeBag()

    init(viewModel: ___VARIABLE_productName___ViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: "___VARIABLE_productName___ViewController",
                   bundle: Bundle(for: ___VARIABLE_productName___ViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // View <- ViewModel

        // View -> ViewModel

    }
}
