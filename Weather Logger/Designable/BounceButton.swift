//
//  BounceButton.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 16/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

class BounceButton: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.04, y: 1.04)

        UIView.animate(withDuration: 0.4, delay: 0, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
}
