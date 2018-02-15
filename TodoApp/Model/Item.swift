//
//  Item.swift
//  TodoApp
//
//  Created by Ravi Tripathi on 14/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import Foundation

//Extended from Encodable to enable storing data.
//Prior to Swift 4, you had to mention it as Encodable, Decodable. Now its just Codable.
class Item: Codable{
    var title : String = ""
    var done : Bool = false
    
}
