//
//  YourPageCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

protocol YourPageCoordinatorDelegate: AnyObject {
    func editBtnClicked()
}

class YourPageCoordinator: MainTabCoordinatorProtocol {
    
    // MARK: outlet
    
    // MARK: property
    
    var navigationController: UINavigationController
    weak var parentsCoordinator: CoordinatorProtocol?
    
    weak var delegate: YourPageCoordinatorDelegate?
    
    // MARK: lifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    func didSelected(tabCoordinator: TabCoordinator) {
        print("didSelected YourPageCoordinator")
        makeNavigationItems()
    }
    
    func makeNavigationItems() { // 네비게이션의 UI를 Set해주는것도 ViewController에서 해줘야 할것같음.. 코디네이터는 화면이동에만 관여해야하지 않을까 todo) 모든 코디네이터의 네비게이션 UI Set을 ViewController 안으로 넣어버리기
        self.navigationController.navigationBar.topItem?.title = "내 커스텀 기록"
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.myRecipickFont(.subTitle1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray]

        let editBtn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editAction(_:)))
        editBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .normal)
        editBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .highlighted)
        
        self.navigationController.navigationBar.topItem?.leftBarButtonItem = nil
        self.navigationController.navigationBar.topItem?.rightBarButtonItem = editBtn
    }
    
    func moveTo(tab: TabCoordinator.Tab) {
        self.parentsCoordinator?.moveTo?(tab: tab)
    }
    
    // MARK: action
    
    @objc func editAction(_ sender: UIButton) {
        self.delegate?.editBtnClicked()
    }
}
