//
//  MainTabBarViewController.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class MainTabBarViewController: UITabBarController, MVVMViewControllerProtocol, SplashViewProtocol {
    
    typealias SelfType = MainTabBarViewController
    typealias MVVMViewModelClassType = MainTabBarViewModel
    
    // MARK: outlet
    
    // MARK: property
    
    var disposeBag: DisposeBag = DisposeBag()
    var isViewModelBinded: Bool = false
    var viewModel: MainTabBarViewModel!
    
    var attachedViewPool: [UIView] = []
    weak var targetView: UIView?
    var attachedView: UIView? = SplashView.instance()
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func bind(viewModel: MVVMViewModel) {
        if type(of: viewModel) == MainTabBarViewModel.self {
            guard let vm: MainTabBarViewModel = (viewModel as? MainTabBarViewModel) else { return }
            
            vm.outputs.error.subscribe(onNext: { [weak self] errMsg in
                CommonAlertView.shared.showOneBtnAlert(message: "오류\n\(errMsg)", btnText: "확인", confirmHandler: {
                    CommonAlertView.shared.hide()
                    self?.hideSplashView(completion: nil)
                })
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.finishedSetBrandList.subscribe(onNext: {
                print("finishedSetBrandList")
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.finishedSetUniqueUUID.subscribe(onNext: {
                print("finishedSetUniqueUUID")
            })
            .disposed(by: self.disposeBag)
            
            Observable
                .zip(vm.outputs.finishedSetUniqueUUID, vm.outputs.finishedSetBrandList, resultSelector: { _, _ in })
                .subscribe(onNext: { [weak self] in
                    self?.checkAndHideSplash()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    // MARK: func
    
    func initUI() {
        
    }
    
    static func makeViewController(viewModel: MainTabBarViewModel) -> MainTabBarViewController? {
        let mainTabBarViewController: MainTabBarViewController = MainTabBarViewController()
        mainTabBarViewController.viewModel = viewModel
        mainTabBarViewController.bindingViewModel(viewModel: mainTabBarViewController.viewModel)
        return mainTabBarViewController
    }
    
    func attachSubView(_ attachedView: UIView) {
        attachedViewPool.append(attachedView)
        self.view.addSubview(attachedView)
        attachedView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(self.tabBar.frame.height)
        }
    }
    
    func detachAllSubView() {
        for i in 0..<self.attachedViewPool.count {
            self.attachedViewPool[i].removeFromSuperview()
        }
        self.attachedViewPool.removeAll()
    }
    
    func startGetInitInfos() {
        self.showSplashView(completion: { [weak self] in
            (self?.attachedView as? SplashView)?.play()
            self?.viewModel.inputs.setBrandList()
            self?.viewModel.inputs.setUniqueUUID()
        })
    }
    
    // MARK: private func
    
    @objc func checkAndHideSplash() {
        if (self.attachedView as? SplashView)?.isFinishAnimationFlag ?? true {
            hideSplashView(completion: nil)
        } else {
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkAndHideSplash), userInfo: nil, repeats: false)
        }
    }
    
    // MARK: action

    
    
    

}
