//
//  APIService.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/14/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    let url = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
    /**
     Fetch and return gnomes.
     
     - Parameter completionHandler: Where your going to use your gnomes.
     
     - Throws: `Error`
     if it couldn't decode properly.
     
     - Returns: List of gnomes `[Gnome]`.
     */
    func fetchGnomes(completionHandler: @escaping ([Gnome]) -> ()) {
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print(err)
                return
            }
            guard let data = dataResponse.data else {return}
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResults.Brastlewark)
            } catch let decodeErr {
                print("Failed to decode", decodeErr)
            }
            
        }
    }
}

struct SearchResults: Decodable {
    let Brastlewark: [Gnome]
}
