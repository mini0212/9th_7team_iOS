//
//  TestViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, CoordinatorViewControllerProtocol {
    
    typealias SelfType = TestViewController
    typealias CoordinatorType = TestCoordinator
    
    var coordinator: TestCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    static func makeTestViewController(coordinator: CoordinatorProtocol) -> TestViewController {
        let testViewController: TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
        if let coordinator = coordinator as? TestCoordinator {
            testViewController.coordinator = coordinator
        }
        return testViewController
    }
    
    static func makeViewController(coordinator: TestCoordinator) -> TestViewController {
        let testViewController: TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
        testViewController.coordinator = coordinator
        return testViewController
    }
    
    @IBAction func popAction(_ sender: Any) {
        self.coordinator.pop(animated: true)
    }
    
    
    
}
