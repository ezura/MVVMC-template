//
//  ViewControllerTemplate.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension Template {
    static let viewControllerTemplate: (String) -> String = { name in
"""
import UIKit
import RxSwift
import RxCocoa

final class \(name)ViewController: UIViewController {

    private let viewModel: \(name)ViewModeling
    private let disposeBag = DisposeBag()

    init(viewModel: \(name)ViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: "\(name)ViewController",
                   bundle: Bundle(for: \(name)ViewController.self))
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
"""
    }
}
