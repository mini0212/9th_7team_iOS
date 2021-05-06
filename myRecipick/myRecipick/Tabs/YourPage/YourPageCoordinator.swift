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
    
    enum Route {
        case detail(String?) // String을 Model Object로 바꿔야할듯? 디테일 하나에 대한 데이터.. API 젭알 나와주세요... ㅠㅠ
    }
    
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
    
    func makeNavigationItems() {
        self.navigationController.navigationBar.topItem?.title = "내 커스텀 기록"
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.myRecipickFont(.subTitle1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray]

        let editBtn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editAction(_:)))
        editBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .normal)
        editBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .highlighted)
        
        self.navigationController.navigationBar.topItem?.leftBarButtonItem = nil
        self.navigationController.navigationBar.topItem?.rightBarButtonItems?.removeAll()
        self.navigationController.navigationBar.topItem?.rightBarButtonItem = editBtn
    }
    
    func moveTo(tab: TabCoordinator.Tab) {
        self.parentsCoordinator?.moveTo?(tab: tab)
    }
    
    func attachViewToTabBar(_ view: UIView) {
        self.parentsCoordinator?.attachViewToTabBar?(view)
    }
    
    func detachAllViewFromTabBar() {
        self.parentsCoordinator?.detachAllViewFromTabBar?()
    }
    
    func present(route: Route, animated: Bool, completion: (() -> Void)?) {
        switch route {
        case .detail(let data):
            DetailViewController()
        }
    }
    
    // MARK: action
    
    @objc func editAction(_ sender: UIButton) {
        self.delegate?.editBtnClicked()
    }
}
