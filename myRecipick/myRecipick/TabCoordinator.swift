//
//  TabCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class TabCoordinator: NSObject, CoordinatorProtocol {
    
    // MARK: property
    
    var rootViewController: UIViewController {
        return tabController
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    let tabController: UITabBarController
    
    let homeCoordinator: HomeCoordinator
    let customCoordinator: CustomCoordinator
    let yourPageCoordinator: YourPageCoordinator
    
    let homeViewController: HomeViewController
    let customViewController: CustomViewController
    let yourPageViewController: YourPageViewController
    
    // MARK: state
    
    weak var currentSelectedTabCoordinator: MainTabCoordinatorProtocol?
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabController = UITabBarController()
        self.homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        self.customCoordinator = CustomCoordinator(navigationController: self.navigationController)
        self.yourPageCoordinator = YourPageCoordinator(navigationController: self.navigationController)

        var controllers: [UIViewController] = []
        homeViewController = HomeViewController.makeViewController(coordinator: self.homeCoordinator, viewModel: HomeViewModel())
        homeViewController.tabBarItem = UITabBarItem(title: "home", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(homeViewController)
        customViewController = CustomViewController()
        customViewController.tabBarItem = UITabBarItem(title: "custom", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(customViewController)
        yourPageViewController = YourPageViewController()
        yourPageViewController.tabBarItem = UITabBarItem(title: "history", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(yourPageViewController)
        tabController.viewControllers = controllers
        self.tabController.tabBar.isTranslucent = false
        self.navigationController.viewControllers = [self.tabController]
        super.init()
        self.tabController.delegate = self
        self.currentSelectedTabCoordinator = self.homeCoordinator
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case self.homeViewController:
            if self.currentSelectedTabCoordinator !== self.homeCoordinator {
                self.homeCoordinator.didSelected(tabCoordinator: self)
                self.currentSelectedTabCoordinator = self.homeCoordinator
            }
        case self.customViewController:
            if self.currentSelectedTabCoordinator !== self.customCoordinator {
                self.customCoordinator.didSelected(tabCoordinator: self)
                self.currentSelectedTabCoordinator = self.customCoordinator
            }
        case self.yourPageViewController:
            if self.currentSelectedTabCoordinator !== self.yourPageCoordinator {
                self.yourPageCoordinator.didSelected(tabCoordinator: self)
                self.currentSelectedTabCoordinator = self.yourPageCoordinator
            }
        default:
            print("selected unkownTab")
        }
    }
}
