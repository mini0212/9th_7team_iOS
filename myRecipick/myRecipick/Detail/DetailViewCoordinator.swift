//
//  DetailViewCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class DetailViewCoordinator: CoordinatorProtocol {
    
    // MARK: outlet
    
    // MARK: property
    var navigationController: UINavigationController
    weak var parentsCoordinator: CoordinatorProtocol?
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: func
    
    // MARK: action
    
    
    
    

}
