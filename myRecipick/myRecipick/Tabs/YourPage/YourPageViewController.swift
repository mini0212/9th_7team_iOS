//
//  YourPageViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YourPageViewController: UIViewController, CoordinatorMVVMViewController, ClassIdentifiable {
    
    typealias MVVMViewModelClassType = YourPageViewModel
    typealias SelfType = YourPageViewController
    typealias CoordinatorType = YourPageCoordinator
    
    // MARK: outlet
    
    // MARK: property
    
    var coordinator: YourPageCoordinator!
    var viewModel: YourPageViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: state
    var isViewModelBinded: Bool = false
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel(viewModel: self.viewModel)
    }
    
    func bind(viewModel: MVVMViewModel) {
        if type(of: viewModel) == YourPageViewModel.self {
            guard let vm: YourPageViewModel = (viewModel as? YourPageViewModel) else { return }
            print("bind!!")
        }
    }
    
    // MARK: func
    static func makeViewController(coordinator: YourPageCoordinator, viewModel: MVVMViewModelClassType) -> YourPageViewController {
        let yourPageViewController: YourPageViewController = UIStoryboard(name: "YourPage", bundle: nil).instantiateViewController(identifier: YourPageViewController.identifier)
        yourPageViewController.coordinator = coordinator
        yourPageViewController.viewModel = viewModel
        return yourPageViewController
    }
    
    func initUI() {
        
    }
    
    // MARK: action
    
}


