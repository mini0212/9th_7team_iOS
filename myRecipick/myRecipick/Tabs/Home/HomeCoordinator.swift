//
//  HomeCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class HomeCoordinator: MainTabCoordinatorProtocol {
    
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
    
    func didSelected(tabCoordinator: TabCoordinator) {
        print("didSelected HomeCoordinator")
        makeNavigationItems()
    }
    
    func makeNavigationItems() {
        self.navigationController.navigationBar.topItem?.title = "홈~?"
        let barButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "square.and.arrow.up")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addTapped))
        self.navigationController.navigationBar.topItem?.leftBarButtonItem = barButtonItem
    }
    
    // MARK: action
    
    @objc func addTapped(sender: UIBarButtonItem) {
        print("얍")
    }
}
