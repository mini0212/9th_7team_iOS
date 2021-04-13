//
//  CustomViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, CoordinatorViewControllerProtocol {
    
    typealias SelfType = CustomViewController
    typealias CoordinatorType = CustomCoordinator

    // MARK: outlet
    
    // MARK: property
    
    var coordinator: CustomCoordinator!
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
    }
    
    // MARK: func
    
    static func makeViewController(coordinator: CustomCoordinator) -> CustomViewController {
        return CustomViewController()
    }
    
    // MARK: action

}
