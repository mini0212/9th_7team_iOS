//
//  HomeViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, CoordinatorMVVMViewController, ClassIdentifiable {
    
    typealias SelfType = HomeViewController
    
    typealias MVVMViewModelClassType = HomeViewModel
    typealias CoordinatorType = HomeCoordinator

    // MARK: outlet

    // MARK: property

    var coordinator: HomeCoordinator!
    var viewModel: HomeViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: state
    var isViewModelBinded: Bool = false

    // MARK: lifeCycle

    deinit {
        print("- \(type(of: self)) deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
    }

    // MARK: func
    
    static func makeViewController(coordinator: HomeCoordinator, viewModel: HomeViewModel) -> HomeViewController {
        let homeViewController: HomeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: HomeViewController.identifier)
        homeViewController.coordinator = coordinator
        homeViewController.viewModel = viewModel
        return homeViewController
    }
    
    func bind(viewModel: MVVMViewModel) {
        
    }

    // MARK: action
    @IBAction func testPushAction(_ sender: Any) {
        self.coordinator?.push(route: .test, animated: true)
    }
    
}
