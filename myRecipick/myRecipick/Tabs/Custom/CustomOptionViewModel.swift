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
    
    private let optionList = BehaviorRelay<[OptionSection]>(value: [])
    var optionListObservable: Observable<[OptionSection]> {
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
            .map({ (data: MenuOptionDataModel) -> [OptionSection] in
                var sectionList: [OptionSection] = []
                data.data.forEach {
                    var itemList: [OptionItem] = []
                    $0.options.forEach {
                        let optionItem = OptionItem(item: $0)
                        itemList.append(optionItem)
                    }
                    let sectionData = OptionSection(option: $0, isSingleSelection: $0.type == "SINGLE", items: itemList)
                    sectionList.append(sectionData)
                }
                return sectionList
            })
            .bind(to: optionList)
            .disposed(by: disposeBag)
    }
    
}
