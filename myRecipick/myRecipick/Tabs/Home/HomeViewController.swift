//
//  HomeViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, CoordinatorViewControllerProtocol, ClassIdentifiable {
    
    typealias SelfType = HomeViewController
    typealias CoordinatorType = HomeCoordinator

    // MARK: outlet
    
    // MARK: property
    
    var coordinator: HomeCoordinator!
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
    }
    
    // MARK: func
    
    static func makeViewController(coordinator: HomeCoordinator) -> HomeViewController {
        let homeViewController: HomeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: HomeViewController.identifier)
        homeViewController.coordinator = coordinator
        return homeViewController
    }
    
    // MARK: action
    @IBAction func testPushAction(_ sender: Any) {
        self.coordinator?.push(route: .test, animated: true)
    }
    
}
