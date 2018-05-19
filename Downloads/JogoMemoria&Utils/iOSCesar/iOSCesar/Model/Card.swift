//
//  Card.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import Foundation

struct Card {
    var indentifier: Int
    var isUp = false
    var isMatched = false
    
    static var lastId = -1
    static func getNextId() -> Int {
        lastId += 1
        return lastId
    }
    
    init() {
       self.indentifier = Card.getNextId()
    }
}
