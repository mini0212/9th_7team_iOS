//
//  TabCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class TabCoordinator: CoordinatorProtocol {
    
    // MARK: property
    
    var rootViewController: UIViewController {
        return tabController
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    let tabController: UITabBarController
    
    let homeCoordinator: HomeCoordinator
    let customCoordinator: CustomCoordinator
    let yourPageCoordinator: YourPageCoordinator
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabController = UITabBarController()
        self.homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        self.customCoordinator = CustomCoordinator(navigationController: self.navigationController)
        self.yourPageCoordinator = YourPageCoordinator(navigationController: self.navigationController)

        var controllers: [UIViewController] = []
        let homeViewController = HomeViewController.makeViewController(coordinator: self.homeCoordinator, viewModel: HomeViewModel())
        homeViewController.tabBarItem = UITabBarItem(title: "home", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(homeViewController)
        let customViewController = CustomViewController()
        customViewController.tabBarItem = UITabBarItem(title: "custom", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(customViewController)
        let yourPageViewController = YourPageViewController()
        yourPageViewController.tabBarItem = UITabBarItem(title: "history", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(yourPageViewController)
        tabController.viewControllers = controllers
        self.tabController.tabBar.isTranslucent = false
        self.navigationController.viewControllers = [self.tabController]
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
}
