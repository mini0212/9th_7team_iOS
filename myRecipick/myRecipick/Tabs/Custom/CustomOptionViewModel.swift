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
    
    func saveCustomOption() {
        var httpRequest = HttpRequest()
        httpRequest.url = "my/custom-menus"
        httpRequest.method = .post
        httpRequest.headers = .customMenus(uniqueId: UniqueUUIDManager.shared.uniqueUUID)
        httpRequest.parameters = [
            "name": "테스트용",
            "menu": CustomMenuModel(id: menu?.id ?? "", name: menu?.name ?? "", image: menu?.image ?? "").toJSONString,
            "optionGroups": customMenuList().toJSONString
        ]
        
        ServerUtil.shared.rx.requestRx(with: httpRequest)
            .subscribe(onNext: { (data: String) in
                print(data)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
      
    }

    private func customMenuList() -> [CustomOptionGroupModel] {
        let item = optionList.value
            .map { option -> CustomOptionGroupModel in
            let selectedItem = option.items
                .filter { $0.isSelected }
                .map { item -> CustomOptionModel in
                    return CustomOptionModel(image: item.item.image, name: item.item.name)
                }
            return CustomOptionGroupModel(id: option.option.id, name: option.option.name, options: selectedItem)
            
        }
        return item
    }
    
}
