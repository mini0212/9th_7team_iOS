//
//  YourPageCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class YourPageCoordinator: MainTabCoordinatorProtocol {
    
    // MARK: outlet
    
    // MARK: property
    
    var navigationController: UINavigationController
    weak var parentsCoordinator: CoordinatorProtocol?
    
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
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.myRecipickFont(.subTitle1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33)]
        self.navigationController.navigationBar.topItem?.leftBarButtonItem = nil
        self.navigationController.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    func moveTo(tab: TabCoordinator.Tab) {
        self.parentsCoordinator?.moveTo?(tab: tab)
    }
    
    // MARK: action
}
