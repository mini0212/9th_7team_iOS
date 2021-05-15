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
    
    // MARK: property
    
    var disposeBag: DisposeBag = DisposeBag()
    var service: YourPageServiceProtocol
    
    // MARK: lifeCycle
    init(service: YourPageServiceProtocol) {
        self.service = service
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    func subscribeInputs() {
        print("subscribeInputs")
    }
    
    // MARK: function
    
    
    
    
    
    

}
