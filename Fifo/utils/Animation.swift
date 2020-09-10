//
//  File.swift
//  Fifo
//
//  Created by Бакулин Семен Александрович on 10.09.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

func smallAnimation(viewController:ViewController){
    
    guard let view = viewController.view else {return}
    let blurEffect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.bounds = view.bounds
    blurView.center = view.center
    blurView.alpha = 0
    view.addSubview(blurView)
    UIView.animate(withDuration: 2, animations: {
        blurView.alpha = 1
        blurView.alpha = 0
    }) { (bool) in
        blurView.removeFromSuperview()
    }
}
