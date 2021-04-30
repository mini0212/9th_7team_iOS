//
//  BrandSelectViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/20.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BrandSelectViewControllerDelegate: AnyObject {
    func pushRequestBrandViewController()
}

class BrandSelectViewController: UIViewController, MVVMViewControllerProtocol, ClassIdentifiable {
    
    typealias SelfType = BrandSelectViewController
    typealias MVVMViewModelClassType = BrandSelectViewModel

    // MARK: outlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var topContentsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomContentsLabel: UILabel!
    
    
    // MARK: property
    var disposeBag: DisposeBag = DisposeBag()
    
    var isViewModelBinded: Bool = false
    var viewModel: BrandSelectViewModel!
    
    weak var delegate: BrandSelectViewControllerDelegate?
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.tableView.register(UINib(nibName: "BrandSelectTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandSelectTableViewCell")
        bindingViewModel(viewModel: self.viewModel)
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    func bind(viewModel: MVVMViewModel) {
        if type(of: viewModel) == BrandSelectViewModel.self {
            guard let vm: BrandSelectViewModel = (viewModel as? BrandSelectViewModel) else { return }
            
            vm.outputs.isLoading
                .subscribe(onNext: {
                    if $0 {
                        print("로딩 on!")
                    } else {
                        print("로딩 off!")
                    }
                })
                .disposed(by: self.disposeBag)
            
            vm.outputs.brands
                .observe(on: MainScheduler.instance)
                .bind(to: self.tableView.rx.items) { tableView, row, item in
                    guard let cell: BrandSelectTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BrandSelectTableViewCell") as? BrandSelectTableViewCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.infoData = item
                    return cell
                }
                .disposed(by: self.disposeBag)
            
            self.tableView.rx.itemSelected
                .subscribe(onNext: { index in
                    print("index: \(index)")
                })
                .disposed(by: self.disposeBag)
            
        }
    }
    
    // MARK: func
    
    static func makeViewController(viewModel: BrandSelectViewModel) -> BrandSelectViewController? {
        let brandSelectViewController: BrandSelectViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: BrandSelectViewController.identifier)
        brandSelectViewController.viewModel = viewModel
        return brandSelectViewController
    }
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContainerView.backgroundColor = .clear
        
        self.topContainerView.backgroundColor = .clear
        self.topContentsLabel.font = UIFont.myRecipickFont(.subTitle1)
        self.topContentsLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.topContentsLabel.text = "브랜드 변경"
        
        self.tableView.separatorStyle = .none
        self.tableView.bounces = false
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
        self.bottomContainerView.backgroundColor = .clear
        self.bottomContentsLabel.font = UIFont.myRecipickFont(.subTitle1)
        self.bottomContentsLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.bottomContentsLabel.text = "브랜드 추가 요청"
        
    }
    
    // MARK: action
    @IBAction func requestNewBrandAction(_ sender: Any) {
        self.dismiss(animated: false, completion: { [weak self] in
            self?.delegate?.pushRequestBrandViewController()
        })
    }
    
}
