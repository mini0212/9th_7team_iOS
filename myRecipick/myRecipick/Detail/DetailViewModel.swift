//
//  DetailViewModel.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

protocol DetailViewModelInput {
    
}

protocol DetailViewModelOutput {
    var error: PublishSubject<String> { get }
    var isLoading: PublishSubject<Bool> { get }
    var detailCustomMenu: BehaviorSubject<CustomMenuDetailObjModel> { get }
    func getIngredients(data: CustomMenuDetailObjModel) -> [CustomMenuDetailOptionGroupObjModel]
}

protocol DetailViewModelType {
    var inputs: DetailViewModelInput { get }
    var outputs: DetailViewModelOutput { get }
}

class DetailViewModel: MVVMViewModel, DetailViewModelType, DetailViewModelInput, DetailViewModelOutput {
    
    // MARK: property
    var inputs: DetailViewModelInput {
        return self
    }
    var outputs: DetailViewModelOutput {
        return self
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var service: DetailServiceProtocol
    var error: PublishSubject<String>
    var isLoading: PublishSubject<Bool>
    var detailCustomMenu: BehaviorSubject<CustomMenuDetailObjModel>
    
    // MARK: lifeCycle
    
    init(service: DetailServiceProtocol) {
        self.service = service
        self.error = .init()
        self.isLoading = .init()
        self.detailCustomMenu = .init(value: CustomMenuDetailObjModel())
        self.service.getObservableDetailInfo().subscribe(onNext: { [weak self] detailObjData in
            self?.detailCustomMenu.onNext(detailObjData)
        })
        .disposed(by: self.disposeBag)
    }
    
    func subscribeInputs() {
        
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: outputFunction
    
    func getIngredients(data: CustomMenuDetailObjModel) -> [CustomMenuDetailOptionGroupObjModel] {
        return data.optionGroups
    }
    
    // MARK: action

}
