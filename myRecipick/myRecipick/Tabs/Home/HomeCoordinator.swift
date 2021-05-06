//
//  HomeCoordinator.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import SideMenu

class HomeCoordinator: MainTabCoordinatorProtocol {
    
    enum Route {
        case requestBrand
    }
    
    // MARK: property
    
    var navigationController: UINavigationController?
    weak var parentsCoordinator: CoordinatorProtocol?
    
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
    
    func push(route: Route, animated: Bool) {
        switch route {
//        case .test:
//            let testCoordinator = TestCoordinator(navigationController: self.navigationController, parentsCoordinator: self)
//            let vc = TestViewController.makeTestViewController(coordinator: testCoordinator)
//            self.navigationController.pushViewController(vc, animated: animated)
        case .requestBrand:
            let vc: RequestBrandViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: RequestBrandViewController.identifier)
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func didSelected(tabCoordinator: TabCoordinator) {
        print("didSelected HomeCoordinator")
        makeNavigationItems()
    }
    
    func makeNavigationItems() {
        self.navigationController?.navigationBar.topItem?.title = ""
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "uilBars")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showBrandSelectView))
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = barButtonItem
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    func moveTo(tab: TabCoordinator.Tab) {
        self.parentsCoordinator?.moveTo?(tab: tab)
    }
    
    func showTip() {
        let tipViewController: HomeTipViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: HomeTipViewController.identifier)
        tipViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(tipViewController, animated: false, completion: {
            tipViewController.tipContainerView.fadeIn(duration: 0.1, completeHandler: nil)
        })
    }
    
    // MARK: action
    
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

extension HomeCoordinator: SideMenuNavigationControllerDelegate {
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

extension HomeCoordinator: BrandSelectViewControllerDelegate {
    func pushRequestBrandViewController() {
        push(route: .requestBrand, animated: true)
    }
}
