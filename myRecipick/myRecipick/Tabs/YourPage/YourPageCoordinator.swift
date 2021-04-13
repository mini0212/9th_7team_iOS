//
//  YourPageCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class YourPageCoordinator: CoordinatorProtocol {
    // MARK: outlet
    
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
    
    // MARK: action
}
