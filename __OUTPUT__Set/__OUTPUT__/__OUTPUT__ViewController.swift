//  
//  __OUTPUT__ViewController.swift
//  mvvmc-template
//  
//  Created by ezura on 2019/03/03.
//  Copyright (c) Yuka Ezura 2019
//  

import UIKit
import RxSwift
import RxCocoa

final class __OUTPUT__ViewController: UIViewController {

    private let viewModel: __OUTPUT__ViewModeling
    private let disposeBag = DisposeBag()

    init(viewModel: __OUTPUT__ViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: "__OUTPUT__ViewController",
                   bundle: Bundle(for: __OUTPUT__ViewController.self))
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
