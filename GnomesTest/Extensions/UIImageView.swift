//
//  UIImageView.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/15/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
