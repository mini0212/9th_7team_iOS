//
//  CoordinatorProtocol.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/13.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {
    var navigationController: UINavigationController { get set }
//    var childCoordinators: [CoordinatorProtocol] { get set } // 샘플에는 이런게 들어있던데 어따쓰는지 몰라서 주석처리...........
}

protocol MainTabCoordinatorProtocol: CoordinatorProtocol {
    func didSelected(tabCoordinator: TabCoordinator)
}

protocol CoordinatorViewControllerBaseProtocol: class {
    associatedtype CoordinatorType: CoordinatorProtocol
    var coordinator: CoordinatorType! { get set }
}

protocol CoordinatorViewControllerProtocol: CoordinatorViewControllerBaseProtocol {
    associatedtype SelfType: CoordinatorViewControllerProtocol
    static func makeViewController(coordinator: CoordinatorType) -> SelfType
}
