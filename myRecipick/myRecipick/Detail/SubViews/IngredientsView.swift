//
//  IngredientsView.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class IngredientsView: UIView, NibIdentifiable {
    
    // MARK: outlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    // MARK: property
    
    var infoData: CustomMenuDetailOptionGroupObjModel? {
        didSet {
            guard let info = self.infoData else { return }
            if let url = info.imageUrl {
                self.imgView.kf.setImage(with: URL(string: url), placeholder: Images.sample.image, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                    self?.imgView.fadeIn(duration: 0.1, completeHandler: nil)
                })
            }
        }
    }
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    
    class func instance() -> IngredientsView? {
        return IngredientsView.nib.instantiate(withOwner: nil, options: nil).first as? IngredientsView
    }
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
    }
    
    // MARK: action

}
