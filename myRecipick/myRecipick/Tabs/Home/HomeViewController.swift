//
//  HomeViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, CoordinatorMVVMViewController, ClassIdentifiable {
    
    typealias SelfType = HomeViewController
    
    typealias MVVMViewModelClassType = HomeViewModel
    typealias CoordinatorType = HomeCoordinator

    // MARK: outlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    // MARK: property

    var coordinator: HomeCoordinator!
    var viewModel: HomeViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: state
    var isViewModelBinded: Bool = false

    // MARK: lifeCycle

    deinit {
        print("- \(type(of: self)) deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.coordinator.makeNavigationItems()
    }

    // MARK: func
    
    static func makeViewController(coordinator: HomeCoordinator, viewModel: HomeViewModel) -> HomeViewController {
        let homeViewController: HomeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: HomeViewController.identifier)
        homeViewController.coordinator = coordinator
        homeViewController.viewModel = viewModel
        return homeViewController
    }
    
    func initUI() {
        self.backgroundView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContainerView.backgroundColor = .clear
        self.titleLabel.font = UIFont.myRecipickFont(.title1)
        self.titleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.titleLabel.numberOfLines = 20
        self.titleLabel.text = LocalizedMap.HOME_TITLE.localized
        self.collectionView.backgroundColor = .clear
        self.bottomContainerView.backgroundColor = UIColor(asset: Colors.homeBottomColor)
    }
    
    func bind(viewModel: MVVMViewModel) {
        
    }

    // MARK: action
    
    @IBAction func showTipAction(_ sender: Any) {
        print("showTopAction")
    }
    
    @IBAction func testPushAction(_ sender: Any) {
        self.coordinator?.push(route: .test, animated: true)
    }
    
    @IBAction func testMoveOtherTabAction(_ sender: Any) {
        self.coordinator?.moveTo(tab: .yourPage)
    }
    
}
