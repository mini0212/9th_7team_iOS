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
    @IBOutlet weak var menuCategoryView: MenuCategoryBar!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    // MARK: property
    
    var coordinator: CustomCoordinator!
    
    private var menuList: [String] = [] {
        didSet {
            menuCollectionView.reloadData()
        }
    }
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        initCategoryView()
        initCollectionView()
    }
    
    private func initNavigationView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationView.setTitle("메뉴선택")
        navigationView.setLeftButtonText("닫기")
        navigationView.leftButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
    
    private func initCategoryView() {
        menuCategoryView.delegate = self
        menuList = ["샌드위치", "찹샐러드"]
        menuCategoryView.menuList = menuList
    }
    
    private func initCollectionView() {
        
    }
    
    // MARK: func
    
    

    // MARK: action

    @objc
    private func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


extension CustomViewController: MenuCategoryBarDelegate {
    func tapTabbar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        print(indexPath)
    }
    
    
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CustomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
}
