//
//  CustomViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, CoordinatorViewControllerProtocol, ClassIdentifiable {
    
    static func makeViewController(coordinator: CustomCoordinator) -> CustomViewController {
        let vc = CustomViewController(nibName: self.identifier, bundle: nil)
        vc.coordinator = coordinator
        return vc
    }
    
    
    typealias SelfType = CustomViewController
    typealias CoordinatorType = CustomCoordinator

    // MARK: outlet
    @IBOutlet weak var navigationView: CustomNavigationView!
    
    // MARK: property
    
    var coordinator: CustomCoordinator!
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
    }
    
    private func initNavigationView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationView.setTitle("메뉴선택")
        navigationView.setLeftButtonText("닫기")
        navigationView.leftButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
    
    // MARK: func
    
    

    // MARK: action

    @objc
    private func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
