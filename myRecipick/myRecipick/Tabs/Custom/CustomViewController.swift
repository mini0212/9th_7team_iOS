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
    
    private var menuList: [String: Any] = [:] {
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
    
    // MARK: func
    
    private func initNavigationView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationView.setTitle("메뉴선택")
        navigationView.setLeftButtonText("닫기")
        navigationView.leftButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
    
    private func initCategoryView() {
        menuCategoryView.delegate = self
        menuList = [
            "샌드위치": ["로스트 치킨 베이컨", "로스트 치킨 아보카도", "로스트 치킨", "스테이크 & 치즈"],
            "찹샐러드": ["로스트 치킨", "스테이크 & 치즈", "터키베이컨 아보카도", "로티세리 치킨"]
        ]
        menuCategoryView.menuList = menuList.keys.sorted()
    }
    
    private func initCollectionView() {
        menuCollectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    }
    
}

// MARK: action

extension CustomViewController {
    @objc
    private func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension CustomViewController: MenuCategoryBarDelegate {
    func tapTabbar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


// MARK: - UICollectionViewDataSource
extension CustomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else { return .init() }
        cell.menuList(list: Array(menuList)[indexPath.item].value as? [String])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
}

// MARK: - UICollectionViewDelegate

extension CustomViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        menuCategoryView.moveIndicator(in: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CustomViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuCollectionView.frame.width, height: menuCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
