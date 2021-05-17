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
        self.tableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
        self.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
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
                    
//                    if 0 > (yOffset + self.minImgResizeScrollYOffset) {
//                        let test = yOffset + self.minImgResizeScrollYOffset
//                        self.mainImgContainerViewWidthConstraint.constant = self.originMainImgContainerViewWidthConstraint + abs(test)
//                        self.mainImgContainerViewHeightConstraint.constant = self.originMainImgContainerViewHeightConstraint + abs(test)
//                    }
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.customMenuInfo
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                if let url = data.imageUrl {
                    self.mainImgView.kf.setImage(with: URL(string: url), placeholder: Images.sample.image, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                        self?.mainImgView.fadeIn(duration: 0.1, completeHandler: nil)
                    })
                    self.menuImgView.kf.setImage(with: URL(string: url), placeholder: Images.sample.image, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                        self?.mainImgView.fadeIn(duration: 0.1, completeHandler: nil)
                    })
                }
                self.customMenuTitleLabel.text = data.name
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.detailCustomMenu
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
                self.menuTitleLabel.text = data.name
                
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.allIngredients
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] data in
                    guard let self = self else { return }
                    self.ingredientsContainerViewHeightConstraint.constant = self.calculateIngredientsContainerViewHeight(data: data)
                    self.makeIngredientsViews(data: data)
                    self.refreshTableViewInset()
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.allIngredients
                .observe(on: MainScheduler.instance)
                .bind(to: self.tableView.rx.items) { tableView, row, item in
                    print("testItem: \(item)")
                    guard let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else { return UITableViewCell() }
                    cell.infoData = item
                    cell.selectionStyle = .none
                    return cell
                }
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
        self.topContentsContainerView.backgroundColor = .blue
        self.topContentsContainerView.isUserInteractionEnabled = false
        self.customMenuTitleLabel.font = UIFont.myRecipickFont(.detailMenuTitle)
        self.customMenuTitleLabel.textColor = UIColor(asset: Colors.white)
        self.menuContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.menuContainerView.layer.cornerRadius = 20
        self.menuTitleLabel.font = UIFont.myRecipickFont(.yourRecipe)
        self.menuTitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.ingredientsContainerView.backgroundColor = .darkGray
        self.ingredientsContainerView.isUserInteractionEnabled = false
        self.tableView.separatorStyle = .none
        
        self.originMainImgContainerViewWidthConstraint = self.mainImgContainerViewWidthConstraint.constant
        self.originMainImgContainerViewHeightConstraint = self.mainImgContainerViewHeightConstraint.constant
        
    }
    
    // MARK: private func
    
    private func calculateIngredientsContainerViewHeight(data: [CustomMenuDetailOptionGroupOptionsObjModel]) -> CGFloat {
        var resultValue: CGFloat = self.ingredientsCellViewHeight
        self.ingredientsContainerViewTotalLineCnt = 1
        let totalIngredientsCnt: Int = data.count
        var currentLineWidth: CGFloat = 0
        for _ in 0..<totalIngredientsCnt {
            if (currentLineWidth + ingredientsCellViewWidth) > self.ingredientsContainerViewMaxWidth {
                resultValue += (self.ingredientsCellBottomInterval + self.ingredientsCellViewHeight)
                self.ingredientsContainerViewTotalLineCnt += 1
                currentLineWidth = 0
            }
            currentLineWidth += (self.ingredientsCellViewWidth + self.ingredientsCellRightInterval)
        }
        
        return resultValue
    }
    
    private func makeNewIngredientsView(data: CustomMenuDetailOptionGroupOptionsObjModel) -> IngredientsView? {
        let newView: IngredientsView? = IngredientsView.instance()
        newView?.infoData = data
        return newView
    }
    
    private func makeIngredientsViews(data: [CustomMenuDetailOptionGroupOptionsObjModel]) {
        self.ingredientsContainerView.removeAllSubview()
        let roundHalfDownNumberOfItemInLine: Int = data.count/self.ingredientsContainerViewTotalLineCnt
        var isExsistRemainder: Bool = false
        if data.count%self.ingredientsContainerViewTotalLineCnt != 0 {
            isExsistRemainder = true
        }
        print("roundHalfDownNumberOfItemInLine:\(roundHalfDownNumberOfItemInLine)")
        var currentYOffset: CGFloat = 0
        var currentIndex: Int = 0
        var numberOfItemInLineCorrectionValue: Int = 0
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
            if isExsistRemainder {
                numberOfItemInLineCorrectionValue = numberOfItemInLineCorrectionValue == 0 ? 1 : 0
            }
            let numberOfItemInLine = roundHalfDownNumberOfItemInLine + numberOfItemInLineCorrectionValue
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
    
    private func refreshTableViewInset() {
        self.topContentsViewHeightConstraint.constant += self.ingredientsContainerViewHeightConstraint.constant
        self.originTopContentsViewHeightConstraint = self.topContentsViewHeightConstraint.constant
        self.tableView.contentInset = UIEdgeInsets(top: self.topContentsViewHeightConstraint.constant, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.originTopContentsViewHeightConstraint)
    }
    
    // MARK: action

}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
