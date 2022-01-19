//
//  Constants.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//

import Foundation
struct Constants {
    
    struct Urls {
        
        // MARK: All POST
        static func urlForGetAllPost() -> URL {
            return URL(string: "https://limitless-forest-49003.herokuapp.com/posts")!
        }
        
        static func urlForUpdateDelete(id: String) -> URL {
            return URL(string: "https://limitless-forest-49003.herokuapp.com/posts/\(id)")!
        }
    }
        
}
