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
    
    func makeNavigationItems() {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "evaCloseFill")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeButtonClicked(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = barButtonItem
    }
    
    func setClearNavigation() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
    
    // MARK: action
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    

}
