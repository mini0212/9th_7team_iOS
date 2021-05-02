//
//  YourPageViewModel.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

class YourPageViewModel: MVVMViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    func subscribeInputs() {
        
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }

}
