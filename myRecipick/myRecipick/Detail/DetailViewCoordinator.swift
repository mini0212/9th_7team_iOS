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
    weak var navigationController: UINavigationController?
    weak var parentsCoordinator: CoordinatorProtocol?
    
    // MARK: lifeCycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    func setClearNavigation() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.navigationController?.dismiss(animated: animated, completion: nil)
    }
    
    // MARK: action
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    

}
