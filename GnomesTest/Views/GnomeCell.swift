//
//  GnomeCell.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/14/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import UIKit
import SDWebImage

class GnomeCell: UITableViewCell {
    
    @IBOutlet weak var gnomeImageView: UIImageView!
    
    @IBOutlet weak var gnomeNameLabel: UILabel!
    
    @IBOutlet weak var gnomeAgeLabel: UILabel!
    
    var gnome: Gnome! {
        didSet {
            gnomeNameLabel.text = gnome.name
            gnomeAgeLabel.text = "Age: \(String(gnome.age))"
            guard let url = URL(string: gnome.thumbnail.toSecureHTTPS()) else {return}
            gnomeImageView.sd_setImage(with: url, completed: nil)
            gnomeImageView.setRounded()
        }
    }
}
