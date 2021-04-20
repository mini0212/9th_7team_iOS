//
//  BrandSelectViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/20.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BrandSelectViewController: UIViewController, MVVMViewControllerProtocol, ClassIdentifiable {
    
    typealias SelfType = BrandSelectViewController
    typealias MVVMViewModelClassType = BrandSelectViewModel

    // MARK: outlet
    
    // MARK: property
    var disposeBag: DisposeBag = DisposeBag()
    
    var isViewModelBinded: Bool = false
    var viewModel: BrandSelectViewModel!
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel(viewModel: self.viewModel)
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    func bind(viewModel: MVVMViewModel) {
        if type(of: viewModel) == BrandSelectViewModel.self {
            guard let vm: BrandSelectViewModel = (viewModel as? BrandSelectViewModel) else { return }
            
            vm.outputs.isLoading
                .subscribe(onNext: {
                    if $0 {
                        print("로딩 on!")
                    } else {
                        print("로딩 off!")
                    }
                })
                .disposed(by: self.disposeBag)
            
            vm.outputs.brands.subscribe(onNext: { [weak self] brands in
                print("brands:\(brands)")
            })
            .disposed(by: self.disposeBag)
            
        }
    }
    
    // MARK: func
    
    static func makeViewController(viewModel: BrandSelectViewModel) -> BrandSelectViewController? {
        let brandSelectViewController: BrandSelectViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: BrandSelectViewController.identifier)
        brandSelectViewController.viewModel = viewModel
        return brandSelectViewController
    }
    
    func initUI() {
        
    }
    
    // MARK: action

}
