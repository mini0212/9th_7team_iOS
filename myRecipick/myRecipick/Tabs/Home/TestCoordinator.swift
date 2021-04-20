//
//  TestCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class TestCoordinator: CoordinatorProtocol {
    
    // MARK: property
    
    var navigationController: UINavigationController
    weak var parentsCoordinator: CoordinatorProtocol?
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController, parentsCoordinator: CoordinatorProtocol?) {
        self.navigationController = navigationController
        self.parentsCoordinator = parentsCoordinator
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    func pop(animated: Bool) {
        self.navigationController.popViewController(animated: animated)
    }
    
    func moveTo(tab: TabCoordinator.Tab) {
        self.parentsCoordinator?.moveTo?(tab: tab)
    }
}
