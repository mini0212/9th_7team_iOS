//
//  CustomOptionViewModel.swift
//  myRecipick
//
//  Created by Min on 2021/05/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CustomOptionViewModel {
    var menu: MenuModel?
    
    private let optionList = BehaviorRelay<[OptionKindModel]>(value: [])
    var optionListObservable: Observable<[OptionKindModel]> {
        return optionList.asObservable()
    }
    
    var disposeBag = DisposeBag()
    
    init(menu: MenuModel) {
        self.menu = menu
    }
    
    func fetchOption() {
        guard let menuItem = menu else { return }
        var httpRequest = HttpRequest()
        httpRequest.url = "menus/\(menuItem.id)/options"
        
        ServerUtil.shared.rx.requestRx(with: httpRequest)
            .subscribe(onNext: { [weak self] (data: MenuOptionDataModel) in
                self?.optionList.accept(data.data)
                print(data)
            }) { error in
                print("error -> \(error)")
            }.disposed(by: disposeBag)
    }
}
