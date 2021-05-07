//
//  DetailViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/04.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController, CoordinatorMVVMViewController, ClassIdentifiable {
    
    typealias SelfType = DetailViewController
    typealias CoordinatorType = DetailViewCoordinator
    typealias MVVMViewModelClassType = DetailViewModel
    

    // MARK: outlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topContentsContainerView: UIView!
    @IBOutlet weak var topContentsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topContentsViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var mainImgContainerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainImgContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customMenuTitleLabel: UILabel!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var ingredientsContainerView: UIView!
    @IBOutlet weak var ingredientsHeightConstraint: NSLayoutConstraint!
    
    // MARK: property
    
    var coordinator: DetailViewCoordinator!
    var disposeBag: DisposeBag = DisposeBag()
    var isViewModelBinded: Bool = false
    var viewModel: DetailViewModel!
    
    let ingredientsContainerViewLeadingTraillingConstraint: CGFloat = 24 // 임의 지정
    let ingredientsCellRightInterval: CGFloat = 4
    let ingredientsCellBottomInterval: CGFloat = 4
    let ingredientsCellViewWidth: CGFloat = 70
    let ingredientsCellViewHeight: CGFloat = 70
    
    var originTopContentsViewHeightConstraint: CGFloat = 0
    var originMainImgContainerViewWidthConstraint: CGFloat = 0
    var originMainImgContainerViewHeightConstraint: CGFloat = 0
    let minImgResizeScrollYOffset: CGFloat = 50
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel(viewModel: self.viewModel)
        self.coordinator.setClearNavigation()
        self.coordinator.makeNavigationItems()
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    
    func bind(viewModel: MVVMViewModel) {
        if type(of: viewModel) == DetailViewModel.self {
            guard let vm: DetailViewModel = (viewModel as? DetailViewModel) else { return }
            
            self.tableView.rx.didScroll
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    let yOffset = self.tableView.contentOffset.y + self.originTopContentsViewHeightConstraint
                    self.topContentsViewTopConstraint.constant = -yOffset
                    var percent: CGFloat = yOffset/self.originTopContentsViewHeightConstraint
                    if 0 > percent {
                        percent = 0
                    }
                    if percent > 1 {
                        percent = 1
                    }
                    
                    if 0 > (yOffset + self.minImgResizeScrollYOffset) {
                        let test = yOffset + self.minImgResizeScrollYOffset
                        self.mainImgContainerViewWidthConstraint.constant = self.originMainImgContainerViewWidthConstraint + abs(test)
                        self.mainImgContainerViewHeightConstraint.constant = self.originMainImgContainerViewHeightConstraint + abs(test)
                    }
            })
            .disposed(by: self.disposeBag)
        }
    }
    
    // MARK: func
    
    static func makeViewController(coordinator: DetailViewCoordinator, viewModel: DetailViewModel) -> DetailViewController {
        let detailViewController: DetailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(identifier: DetailViewController.identifier)
        detailViewController.coordinator = coordinator
        detailViewController.viewModel = viewModel
        return detailViewController
    }
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = .purple // 어떤 색갈이 나올 수 있는지 알아야함
        self.mainContainerView.backgroundColor = .clear
        self.tableView.dataSource = self
        self.topContentsContainerView.backgroundColor = .clear
        self.topContentsContainerView.isUserInteractionEnabled = false
        self.customMenuTitleLabel.font = UIFont.myRecipickFont(.detailMenuTitle)
        self.customMenuTitleLabel.textColor = UIColor(asset: Colors.white)
        self.menuContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.menuContainerView.layer.cornerRadius = 20
        self.menuTitleLabel.font = UIFont.myRecipickFont(.yourRecipe)
        self.menuTitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.ingredientsContainerView.backgroundColor = .green
        self.ingredientsContainerView.isUserInteractionEnabled = false
        self.ingredientsHeightConstraint.constant = calculateIngredientsContainerViewHeight()
        self.topContentsViewHeightConstraint.constant += self.ingredientsHeightConstraint.constant
        self.originTopContentsViewHeightConstraint = self.topContentsViewHeightConstraint.constant
        self.tableView.contentInset = UIEdgeInsets(top: self.topContentsViewHeightConstraint.constant, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.originTopContentsViewHeightConstraint)
        
        self.originMainImgContainerViewWidthConstraint = self.mainImgContainerViewWidthConstraint.constant
        self.originMainImgContainerViewHeightConstraint = self.mainImgContainerViewHeightConstraint.constant
        
    }
    
    func getIngredientsViewCnt() -> Int {
        // todo API나오면 개발예정
        return 50
    }
    
    func calculateIngredientsContainerViewHeight() -> CGFloat {
        var resultValue: CGFloat = self.ingredientsCellViewHeight
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let enableMaxWidth: CGFloat = screenWidth - (self.ingredientsContainerViewLeadingTraillingConstraint * 2)
        let totalIngredientsCnt: Int = getIngredientsViewCnt()
        
        var currentLineWidth: CGFloat = 0
        for _ in 0..<totalIngredientsCnt {
            if (currentLineWidth + self.ingredientsCellRightInterval + ingredientsCellViewWidth) > enableMaxWidth {
                resultValue += (self.ingredientsCellBottomInterval + self.ingredientsCellViewHeight)
                currentLineWidth = 0
                continue
            }
            currentLineWidth += (self.ingredientsCellBottomInterval + self.ingredientsCellViewHeight)
        }
        
        return resultValue
    }
    
    // MARK: action

}


extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        if indexPath.row == 0 {
            cell.backgroundColor = .brown
        }
        return cell
    }
    
    
}
