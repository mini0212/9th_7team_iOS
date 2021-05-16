//
//  YourPageViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YourPageViewController: UIViewController, CoordinatorMVVMViewController, ClassIdentifiable, ActivityIndicatorable {
    
    typealias MVVMViewModelClassType = YourPageViewModel
    typealias SelfType = YourPageViewController
    typealias CoordinatorType = YourPageCoordinator
    
    // MARK: outlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContentsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: property
    
    var coordinator: YourPageCoordinator!
    var viewModel: YourPageViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    var checkedIndexRowsSet: Set<Int> = Set()
    
    var zeroItemCntView: YourPageZeroYourrecipeView? = YourPageZeroYourrecipeView.instance()
    
    // MARK: state
    var isViewModelBinded: Bool = false
    var isEditable: Bool = false {
        didSet {
            SetEditableUI(isEditable: self.isEditable)
            self.tableView.reloadData()
        }
    }
    
    // MARK: lifeCycle
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel(viewModel: self.viewModel)
        self.coordinator.delegate = self
        self.tableView.register(UINib(nibName: "YourPageTableViewCell", bundle: nil), forCellReuseIdentifier: "YourPageTableViewCell")
        self.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    func bind(viewModel: MVVMViewModel) {
        if type(of: viewModel) == YourPageViewModel.self {
            guard let vm: YourPageViewModel = (viewModel as? YourPageViewModel) else { return }
            vm.outputs.customMenus
                .observe(on: MainScheduler.instance)
                .bind(to: self.tableView.rx.items) { tableView, row, item in
                    guard let cell: YourPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "YourPageTableViewCell") as? YourPageTableViewCell else { return UITableViewCell() }
                    cell.infoData = item
                    cell.row = row
                    cell.isEditable = self.isEditable
                    cell.delegate = self
                    cell.selectionStyle = .none
                    if self.checkedIndexRowsSet.contains(row) {
                        cell.isChecked = true
                    } else {
                        cell.isChecked = false
                    }
                    cell.refreshStateUI()
                    
                    return cell
                }
                .disposed(by: self.disposeBag)
            
            vm.outputs.customMenus
                .map { value in
                    if value.count == 0 {
                        self.zeroItemCntView?.isHidden = false
                    } else {
                        self.zeroItemCntView?.isHidden = true
                    }
                }
                .subscribe(onNext: {
                    
                })
                .disposed(by: self.disposeBag)
            
            vm.outputs.error.subscribe(onNext: { msg in
                CommonAlertView.shared.showOneBtnAlert(message: "오류", subMessage: msg, btnText: "확인", confirmHandler: {
                    CommonAlertView.shared.hide()
                })
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.isLoading.subscribe(onNext: { [weak self] in
                if $0 {
                    self?.startIndicatorAnimating()
                } else {
                    self?.stopIndicatorAnimating()
                }
            })
            .disposed(by: self.disposeBag)
            
            vm.outputs.presentDetailView.subscribe(onNext: { [weak self] data in
                self?.coordinator.present(route: .detail(data), animated: true, presentStyle: .fullScreen, completion: nil)
            })
            .disposed(by: self.disposeBag)
        
        }
    }
    
    // MARK: func
    
    static func makeViewController(coordinator: YourPageCoordinator, viewModel: MVVMViewModelClassType) -> YourPageViewController {
        let yourPageViewController: YourPageViewController = UIStoryboard(name: "YourPage", bundle: nil).instantiateViewController(identifier: YourPageViewController.identifier)
        yourPageViewController.coordinator = coordinator
        yourPageViewController.viewModel = viewModel
        return yourPageViewController
    }
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContentsView.backgroundColor = .clear
        
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        if let zeroItemCntView = self.zeroItemCntView {
            self.mainContentsView.addSubview(zeroItemCntView)
            zeroItemCntView.snp.makeConstraints { (make) in
                make.top.equalTo(mainContentsView.snp.top).offset(0)
                make.bottom.equalTo(mainContentsView.snp.bottom).offset(0)
                make.leading.equalTo(mainContentsView.snp.leading).offset(0)
                make.trailing.equalTo(mainContentsView.snp.trailing).offset(0)
            }
            zeroItemCntView.isHidden = true
        }
    }
    
    func SetEditableUI(isEditable: Bool) {
        if isEditable {
            showDeleteBtnContainerView()
            makeEditableNavigationItems()
        } else {
            removeDeleteBtnContainerView()
            self.coordinator.makeNavigationItems()
        }
    }
    
    func makeEditableNavigationItems() {
        self.coordinator.navigationController?.navigationBar.topItem?.title = ""
        self.coordinator.navigationController?.navigationBar.topItem?.leftBarButtonItem = nil
        refreshEditCheckedCntNaviItem()
    }
    
    func refreshEditCheckedCntNaviItem() {
        let allUnckeckBtn = UIBarButtonItem(title: "선택 해제", style: .plain, target: self, action: #selector(allUncheckAction(_:)))
        allUnckeckBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .normal)
        allUnckeckBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .highlighted)
        
        let checkedCntBtn = UIBarButtonItem(title: "\(self.checkedIndexRowsSet.count)", style: .plain, target: self, action: nil)
        checkedCntBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.primaryNormal) ?? .lightGray], for: .disabled)
        checkedCntBtn.isEnabled = false
        
        self.coordinator.navigationController?.navigationBar.topItem?.rightBarButtonItems = [allUnckeckBtn, checkedCntBtn]
        
        let editCompleteBtn = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(editCompleteAction(_:)))
        editCompleteBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .normal)
        editCompleteBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.myRecipickFont(.body1), NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.grayScale33) ?? .lightGray], for: .highlighted)
        self.coordinator.navigationController?.navigationBar.topItem?.leftBarButtonItem = editCompleteBtn
    }
    
    func showDeleteBtnContainerView() {
        guard let deleteBtnView = EditYourCustomHistroyConfirmBtnView.instance() else { return }
        deleteBtnView.delegate = self
        self.coordinator.attachViewToTabBar(deleteBtnView)
    }
    
    func removeDeleteBtnContainerView() {
        self.coordinator.detachAllViewFromTabBar()
    }
    
    
    // MARK: action
    
    @objc func allUncheckAction(_ sender: UIButton) {
        self.checkedIndexRowsSet.removeAll()
        refreshEditCheckedCntNaviItem()
        self.tableView.reloadData()
    }
    
    @objc func editCompleteAction(_ sender: UIButton) {
        self.checkedIndexRowsSet.removeAll()
        self.isEditable = !self.isEditable
    }
    
}


extension YourPageViewController: YourPageCoordinatorDelegate {
    func editBtnClicked() {
        self.isEditable = !self.isEditable
    }
}

extension YourPageViewController: YourPageTableViewCellDelegate {
    func isClicked(_ cell: UITableViewCell, indexPathRow: Int) {
        if self.checkedIndexRowsSet.contains(indexPathRow) {
            self.checkedIndexRowsSet.remove(indexPathRow)
        } else {
            self.checkedIndexRowsSet.insert(indexPathRow)
        }
        self.tableView.reloadRows(at: [IndexPath(row: indexPathRow, section: 0)], with: .automatic)
        refreshEditCheckedCntNaviItem()
    }
    
    func cellClicked(indexPathRow: Int, data: CustomMenuObjModel) {
        if !self.isEditable {
            self.viewModel.inputs.requestDetailCustomMenuInfo(data: data)
        }
    }
}

extension YourPageViewController: EditYourCustomHistroyConfirmBtnViewDelegate {
    func checkedItemDeleteBtnClicked() {
        print("delete Items!!!!")
    }
}

extension YourPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }

}


