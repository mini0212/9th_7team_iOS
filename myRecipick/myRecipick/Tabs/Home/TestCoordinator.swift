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
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    func pop(animated: Bool) {
        self.navigationController.popViewController(animated: animated)
    }
    
    
    
}
