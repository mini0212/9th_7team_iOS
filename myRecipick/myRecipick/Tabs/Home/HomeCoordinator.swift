//
//  HomeCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
    enum Route {
        case test
    }
    
    // MARK: property
    
    var navigationController: UINavigationController
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    func push(route: Route, animated: Bool) {
        switch route {
        case .test:
            let testCoordinator = TestCoordinator(navigationController: self.navigationController)
            let vc = TestViewController.makeTestViewController(coordinator: testCoordinator)
            self.navigationController.pushViewController(vc, animated: animated)
        }
    }
}
