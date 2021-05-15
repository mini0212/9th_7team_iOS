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
    
}

protocol YourPageViewModelOutput {
    var error: PublishSubject<String> { get }
    var customMenus: BehaviorSubject<[CustomMenuObjModel]> { get }
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
    var customMenus: BehaviorSubject<[CustomMenuObjModel]>
    
    // MARK: lifeCycle
    init(service: YourPageServiceProtocol) {
        self.service = service
        self.error = .init()
        self.customMenus = .init(value: [])
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
    
    // MARK: function
    

}
