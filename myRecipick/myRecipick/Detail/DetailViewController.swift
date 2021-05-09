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
    @IBOutlet weak var ingredientsContainerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var ingredientsContainerViewTraillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var ingredientsContainerViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: property
    
    var coordinator: DetailViewCoordinator!
    var disposeBag: DisposeBag = DisposeBag()
    var isViewModelBinded: Bool = false
    var viewModel: DetailViewModel!
    
    lazy var ingredientsContainerViewMaxWidth: CGFloat = UIScreen.main.bounds.width - self.ingredientsContainerViewLeadingConstraint.constant - self.ingredientsContainerViewTraillingConstraint.constant
    var ingredientsContainerViewTotalLineCnt: Int = 0
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        self.ingredientsContainerView.backgroundColor = .darkGray
        self.ingredientsContainerView.isUserInteractionEnabled = false
        self.ingredientsContainerViewHeightConstraint.constant = calculateIngredientsContainerViewHeight()
        self.topContentsViewHeightConstraint.constant += self.ingredientsContainerViewHeightConstraint.constant
        self.originTopContentsViewHeightConstraint = self.topContentsViewHeightConstraint.constant
        self.tableView.contentInset = UIEdgeInsets(top: self.topContentsViewHeightConstraint.constant, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.originTopContentsViewHeightConstraint)
        
        self.originMainImgContainerViewWidthConstraint = self.mainImgContainerViewWidthConstraint.constant
        self.originMainImgContainerViewHeightConstraint = self.mainImgContainerViewHeightConstraint.constant
        
        // testCode, API가 나오면 옵저빙해서 Set해주자!
        var mockData: [String] = []
        for _ in 0..<getIngredientsViewCnt() {
            mockData.append("temp")
        }
        makeIngredientsViews(data: mockData)
        // testCode, API가 나오면 옵저빙해서 Set해주자!
    }
    
    func getIngredientsViewCnt() -> Int {
        // todo API나오면 개발예정
        return 13
    }
    
    func calculateIngredientsContainerViewHeight() -> CGFloat {
        var resultValue: CGFloat = self.ingredientsCellViewHeight
        self.ingredientsContainerViewTotalLineCnt = 1
        let totalIngredientsCnt: Int = getIngredientsViewCnt()
        var currentLineWidth: CGFloat = 0
        for _ in 0..<totalIngredientsCnt {
            if (currentLineWidth + ingredientsCellViewWidth) > self.ingredientsContainerViewMaxWidth {
                resultValue += (self.ingredientsCellBottomInterval + self.ingredientsCellViewHeight)
                self.ingredientsContainerViewTotalLineCnt += 1
                currentLineWidth = 0
            }
            currentLineWidth += (self.ingredientsCellViewWidth + self.ingredientsCellRightInterval)
        }
        if currentLineWidth != 0 {
            resultValue += (self.ingredientsCellBottomInterval + self.ingredientsCellViewHeight)
            self.ingredientsContainerViewTotalLineCnt += 1
        }
        
        return resultValue
    }
    
    // MARK: private func
    
    private func makeNewIngredientsView(data: String) -> IngredientsView? { // 모델 생기면 인풋 파람 교체예정
        let newView: IngredientsView? = IngredientsView.instance()
        return newView
    }
    
    private func makeIngredientsViews(data: [String]) { // 모델 생기면 인풋 파람 교체예정, viewModel에서 옵저빙하자.
        self.ingredientsContainerView.removeAllSubview()
        var numberOfItemInLine: Int = data.count/self.ingredientsContainerViewTotalLineCnt
        if data.count%self.ingredientsContainerViewTotalLineCnt != 0 {
            numberOfItemInLine += 1
        }
        print("numberOfItemInLine:\(numberOfItemInLine)")
        var currentYOffset: CGFloat = 0
        var currentIndex: Int = 0
        while true {
            if currentIndex > data.count - 1 {
                break
            }
            let lineContainerView: ReleaseCheckPrintView = ReleaseCheckPrintView()
            lineContainerView.backgroundColor = .lightGray
            self.ingredientsContainerView.addSubview(lineContainerView)
            lineContainerView.snp.makeConstraints { (make) in
                make.top.equalTo(self.ingredientsContainerView.snp.top).offset(currentYOffset)
                make.centerX.equalTo(self.ingredientsContainerView.snp.centerX).offset(0)
                make.height.equalTo(self.ingredientsCellViewHeight)
            }
            weak var beforeItemView: IngredientsView?
            for i in 0..<numberOfItemInLine {
                if currentIndex > data.count - 1 {
                    break
                }
                let item = data[currentIndex]
                guard let itemView: IngredientsView = self.makeNewIngredientsView(data: item) else { print("detail Item Index error") ; continue }
                lineContainerView.addSubview(itemView)
                if i == 0 && currentIndex == data.count - 1 {
                    itemView.snp.makeConstraints { (make) in
                        make.top.equalTo(lineContainerView.snp.top).offset(0)
                        make.width.equalTo(self.ingredientsCellViewWidth)
                        make.height.equalTo(self.ingredientsCellViewHeight)
                        make.leading.equalTo(lineContainerView.snp.leading).offset(0)
                        make.trailing.equalTo(lineContainerView.snp.trailing).offset(0)
                    }
                } else if i == 0 {
                    itemView.snp.makeConstraints { (make) in
                        make.top.equalTo(lineContainerView.snp.top).offset(0)
                        make.leading.equalTo(lineContainerView.snp.leading).offset(0)
                        make.width.equalTo(self.ingredientsCellViewWidth)
                        make.height.equalTo(self.ingredientsCellViewHeight)
                    }
                    beforeItemView = itemView
                } else if i == (numberOfItemInLine - 1) || currentIndex == data.count - 1 {
                    guard let nonNullBeforeItemView = beforeItemView else { print("detail Item Index error") ; continue }
                    itemView.snp.makeConstraints { (make) in
                        make.top.equalTo(lineContainerView.snp.top).offset(0)
                        make.leading.equalTo(nonNullBeforeItemView.snp.trailing).offset(self.ingredientsCellRightInterval)
                        make.width.equalTo(self.ingredientsCellViewWidth)
                        make.height.equalTo(self.ingredientsCellViewHeight)
                        make.trailing.equalTo(lineContainerView.snp.trailing).offset(0)
                    }
                    currentYOffset += (self.ingredientsCellViewHeight + self.ingredientsCellBottomInterval)
                } else {
                    guard let nonNullBeforeItemView = beforeItemView else { print("detail Item Index error") ; continue }
                    itemView.snp.makeConstraints { (make) in
                        make.top.equalTo(lineContainerView.snp.top).offset(0)
                        make.leading.equalTo(nonNullBeforeItemView.snp.trailing).offset(self.ingredientsCellRightInterval)
                        make.width.equalTo(self.ingredientsCellViewWidth)
                        make.height.equalTo(self.ingredientsCellViewHeight)
                    }
                    beforeItemView = itemView
                }
                currentIndex += 1
            }
        }
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
