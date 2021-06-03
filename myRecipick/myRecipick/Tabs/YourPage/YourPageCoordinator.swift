//
//  YourPageCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import SideMenu

protocol YourPageCoordinatorDelegate: AnyObject {
    func editBtnClicked()
}

class YourPageCoordinator: MainTabCoordinatorProtocol {
    
    enum Route {
        case requestBrand
        case detail(DetailService.DetailServiceInfoModel)
    }
    
    // MARK: outlet
    
    // MARK: property
    
    var navigationController: UINavigationController?
    weak var parentsCoordinator: CoordinatorProtocol?
    
    weak var delegate: YourPageCoordinatorDelegate?
    
    let sideMenuWidth: CGFloat = 232.0
    
    let dimmedView: UIView = UIView()
    var isDimmed: Bool = false
    
    // MARK: lifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dimmedView.frame = CGRect(x: 0, y: 0, width: self.navigationController?.view.frame.width ?? 0, height: self.navigationController?.view.frame.height ?? 0)
        self.dimmedView.backgroundColor = UIColor(asset: Colors.dimmed)
        self.dimmedView.alpha = 0
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    func didSelected(tabCoordinator: TabCoordinator) {
        print("didSelected YourPageCoordinator")
        makeNavigationItems()
    }
    
    func makeNavigationItems() {
        self.navigationController?.navigationBar.topItem?.title = "내 커스텀 기록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.myRecipickFont(.subTitle1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray]

        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = nil
        makeEditBtn()
    }
    
    func makeEditBtn() {
        let editBtn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editAction(_:)))
        editBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .normal)
        editBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .highlighted)
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItems?.removeAll()
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = editBtn
        let barButtonItem = UIBarButtonItem(image: Images.uilBars.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showBrandSelectView))
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = barButtonItem
    }
    
    func removeRightBarButtonItems() {
        self.navigationController?.navigationBar.topItem?.rightBarButtonItems?.removeAll()
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    func moveTo(tab: TabCoordinator.Tab) {
        self.parentsCoordinator?.moveTo?(tab: tab)
    }
    
    func attachViewToTabBar(_ view: UIView) {
        self.parentsCoordinator?.attachViewToTabBar?(view)
    }
    
    func detachAllViewFromTabBar() {
        self.parentsCoordinator?.detachAllViewFromTabBar?()
    }
    
    func present(route: Route, animated: Bool, presentStyle: UIModalPresentationStyle = .pageSheet, completion: (() -> Void)?) {
        switch route {
        case .requestBrand:
            break
        case .detail(let data):
            let navigationController: UINavigationController = UINavigationController()
            let vc = DetailViewController.makeViewController(coordinator: DetailViewCoordinator(navigationController: navigationController), viewModel: DetailViewModel(service: DetailService(data: data)))
            navigationController.setViewControllers([vc], animated: false)
            navigationController.modalPresentationStyle = presentStyle
            self.navigationController?.present(navigationController, animated: animated, completion: completion)
        }
    }
    
    func push(route: Route, animated: Bool) {
        switch route {
        case .requestBrand:
            let vc: RequestBrandViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: RequestBrandViewController.identifier)
            self.navigationController?.pushViewController(vc, animated: animated)
        case .detail:
            break
        }
    }
    
    // MARK: action
    
    @objc func editAction(_ sender: UIButton) {
        self.delegate?.editBtnClicked()
    }
    
    @objc func showBrandSelectView(sender: UIBarButtonItem) {
        guard let brandSelectViewController: BrandSelectViewController = BrandSelectViewController.makeViewController(viewModel: BrandSelectViewModel(service: BrandSelectService())) else { return }
        brandSelectViewController.delegate = self
        let menu = SideMenuNavigationController(rootViewController: brandSelectViewController)
        menu.leftSide = true
        menu.menuWidth = self.sideMenuWidth
        menu.presentationStyle = .menuSlideIn
        menu.sideMenuDelegate = self
        
        self.navigationController?.present(menu, animated: true, completion: nil)
    }
}

extension YourPageCoordinator: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        if !self.isDimmed {
            self.isDimmed = true
            self.navigationController?.view.addSubview(self.dimmedView)
            self.dimmedView.fadeIn(duration: 0.1, completeHandler: nil)
        }
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.dimmedView.fadeOut(duration: 0.1, completeHandler: { [weak self] in
            self?.dimmedView.removeFromSuperview()
            self?.isDimmed = false
        })
    }
}

extension YourPageCoordinator: BrandSelectViewControllerDelegate {
    func pushRequestBrandViewController() {
        push(route: .requestBrand, animated: true)
    }
}

