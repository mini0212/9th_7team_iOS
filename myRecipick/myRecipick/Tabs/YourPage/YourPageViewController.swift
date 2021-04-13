//
//  YourPageViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class YourPageViewController: UIViewController, CoordinatorViewControllerProtocol {
    
    typealias SelfType = YourPageViewController
    typealias CoordinatorType = YourPageCoordinator
    
    // MARK: outlet
    
    // MARK: property
    
    var coordinator: YourPageCoordinator!
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
    }
    
    // MARK: func
    
    static func makeViewController(coordinator: YourPageCoordinator) -> YourPageViewController {
        return YourPageViewController()
    }
    
    // MARK: action
    
}
