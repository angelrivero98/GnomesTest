//
//  Gnome.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/14/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import Foundation

class Gnome: Decodable {
    
    var id: Int
    var name : String
    var thumbnail: String
    var age : Int
    var weight : Float
    var height : Float
    var hair_color : String
    var professions : [String]
    var friends : [String]

}
