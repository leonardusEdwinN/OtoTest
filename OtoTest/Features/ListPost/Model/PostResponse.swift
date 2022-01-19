//
//  PostResponse.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//

import Foundation

struct PostResponse : Codable {
    let status : String?
    let totalResults : Int?
    let articles : [Post]
}
