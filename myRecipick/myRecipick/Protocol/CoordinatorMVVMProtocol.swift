//
//  CoordinatorMVVMProtocol.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/18.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

protocol CoordinatorMVVMViewController: CoordinatorViewControllerBaseProtocol, MVVMViewControllerBaseProtocol {
    associatedtype SelfType: CoordinatorMVVMViewController
    static func makeViewController(coordinator: CoordinatorType, viewModel: MVVMViewModelClassType) -> SelfType
}
