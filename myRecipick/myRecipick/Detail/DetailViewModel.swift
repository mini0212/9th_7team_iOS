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
    var customMenuInfo: BehaviorSubject<CustomMenuObjModel> { get }
    var allIngredients: BehaviorSubject<[CustomMenuDetailOptionGroupOptionsObjModel]> { get }
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
    var customMenuInfo: BehaviorSubject<CustomMenuObjModel>
    var allIngredients: BehaviorSubject<[CustomMenuDetailOptionGroupOptionsObjModel]>
    
    // MARK: lifeCycle
    
    init(service: DetailServiceProtocol) {
        self.service = service
        self.error = .init()
        self.isLoading = .init()
        self.detailCustomMenu = .init(value: CustomMenuDetailObjModel())
        self.allIngredients = .init(value: [])
        self.customMenuInfo = .init(value: CustomMenuObjModel())
        self.service.getObservableDetailInfo().subscribe(onNext: { [weak self] detailObjData in
            guard let self = self else { return }
            self.detailCustomMenu.onNext(detailObjData)
            self.allIngredients.onNext(self.getAllIngredients(data: detailObjData))
        })
        .disposed(by: self.disposeBag)
        self.service.getObservableCustomMenu().subscribe(onNext: { [weak self] customMenuObjData in
            guard let self = self else { return }
            self.customMenuInfo.onNext(customMenuObjData)
        })
        .disposed(by: self.disposeBag)
        
    }
    
    func subscribeInputs() {
        
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: output function
    
    // MARK: private function
    
    private func getAllIngredients(data: CustomMenuDetailObjModel) -> [CustomMenuDetailOptionGroupOptionsObjModel] {
        var returnArr: [CustomMenuDetailOptionGroupOptionsObjModel] = []
        let optionGroups = data.optionGroups
        for i in 0..<optionGroups.count {
            let optionGroupItem = optionGroups[i]
            for j in 0..<optionGroupItem.options.count {
                var item = optionGroupItem.options[j]
                item.category = optionGroupItem.name
                returnArr.append(item)
            }
        }
        return returnArr
    }

}
