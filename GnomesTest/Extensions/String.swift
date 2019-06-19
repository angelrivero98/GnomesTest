//
//  String.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/15/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
    
    func weightFormat(weight: Int) -> String {
        return "Weight: " + String(weight)
    }
    
    func heightFormat(height: Int) -> String {
        return "Height: " + String(height)
    }
    
    func ageFormat(age: Int) -> String {
        return "Age: " + String(age)
    }
}
