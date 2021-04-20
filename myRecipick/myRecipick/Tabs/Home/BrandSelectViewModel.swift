//
//  BrandSelectViewModel.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/20.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

protocol BrandSelectViewModelInput {
    
}

protocol BrandSelectViewModelOutput {
    var isLoading: PublishSubject<Bool> { get }
    var brands: BehaviorSubject<[BrandObjectModel]> { get }
}

protocol BrandSelectViewModelType {
    var inputs: BrandSelectViewModelInput { get }
    var outputs: BrandSelectViewModelOutput { get }
}

class BrandSelectViewModel: MVVMViewModel, BrandSelectViewModelInput, BrandSelectViewModelOutput, BrandSelectViewModelType {
    
    // MARK: outlet
    
    // MARK: property
    
    let service: BrandSelectServiceProtocol
    var disposeBag: DisposeBag = DisposeBag()
    
    var inputs: BrandSelectViewModelInput {
        return self
    }
    var outputs: BrandSelectViewModelOutput {
        return self
    }
    
    // MARK: state
    var isLoading: PublishSubject<Bool>
    
    // MARK: data
    var brands: BehaviorSubject<[BrandObjectModel]>
    
    // MARK: lifeCycle
    
    init(service: BrandSelectServiceProtocol) {
        self.service = service
        self.isLoading = PublishSubject()
        self.brands = .init(value: self.service.getAllBrandInfos())
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    // MARK: action
    
    func subscribeInputs() {
        
    }
    

}
