//
//  YourPageViewModel.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

protocol YourPageViewModelInput {
    func requestDetailCustomMenuInfo(data: CustomMenuObjModel)
}

protocol YourPageViewModelOutput {
    var error: PublishSubject<String> { get }
    var isLoading: PublishSubject<Bool> { get }
    var customMenus: BehaviorSubject<[CustomMenuObjModel]> { get }
    var presentDetailView: PublishSubject<CustomMenuDetailObjModel> { get }
}

protocol YourPageViewModelType {
    var inputs: YourPageViewModelInput { get }
    var outputs: YourPageViewModelOutput { get }
}

class YourPageViewModel: MVVMViewModel, YourPageViewModelType, YourPageViewModelInput, YourPageViewModelOutput {
    
    // MARK: property
    var inputs: YourPageViewModelInput {
        return self
    }
    
    var outputs: YourPageViewModelOutput {
        return self
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var service: YourPageServiceProtocol
    var error: PublishSubject<String>
    var isLoading: PublishSubject<Bool>
    var customMenus: BehaviorSubject<[CustomMenuObjModel]>
    var presentDetailView: PublishSubject<CustomMenuDetailObjModel>
    
    // MARK: lifeCycle
    init(service: YourPageServiceProtocol) {
        self.service = service
        self.error = .init()
        self.isLoading = .init()
        self.customMenus = .init(value: [])
        self.presentDetailView = .init()
        self.service.getYourCustomMenus().subscribe(onNext: { [weak self] response in
            self?.customMenus.onNext(response)
        })
        .disposed(by: self.disposeBag)
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    func subscribeInputs() {
        self.service.error.subscribe(onNext: { [weak self] err in
            self?.error.onNext(err)
        })
        .disposed(by: self.disposeBag)
    }
    
    // MARK: input function
    func requestDetailCustomMenuInfo(data: CustomMenuObjModel) {
        self.isLoading.onNext(true)
        self.service.getDetailCustomMenuData(data: data).subscribe(onNext: { [weak self] responseData in
            self?.presentDetailView.onNext(responseData)
        }, onCompleted: { [weak self] in
            self?.isLoading.onNext(false)
        })
        .disposed(by: self.disposeBag)
    }
    
    // MARK: output function
    
    
    // MARK: private function
    

}
