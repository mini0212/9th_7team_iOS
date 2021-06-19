//
//  SplashView.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import Lottie

class SplashView: UIView, NibIdentifiable {

    // MARK: IBOutlet
    @IBOutlet weak var animationView: AnimationView!
    
    // MARK: property
    
    var isFinishAnimationFlag: Bool = false
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: private function
    
    private func initUI() {
        self.animationView.backgroundColor = .clear
        self.animationView.animation = Animation.named("Splash")
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.loopMode = .playOnce
    }
    
    // MARK: internal function
    
    class func instance() -> SplashView? {
        return nib.instantiate(withOwner: nil, options: nil).first as? SplashView
    }
    
    func play() {
        self.animationView.play(completion: { [weak self] _ in
            self?.isFinishAnimationFlag = true
        })
    }
    
    // MARK: private function
    
    
}
