//
//  Quotes.swift
//  KeyboardOfMiddleEarth
//
//  Created by ooo on 6/1/15.
//  Copyright (c) 2015 Rohan Revival. All rights reserved.
//

import Foundation

import UIKit

class Quote: NSObject {
    
    let text: String?
    var movie: String?
    var character: String?
    var tags: String?
    
    init(json: NSDictionary) {
        self.text = json["text"] as? String
        self.movie = json["movie"] as? String
        self.character = json["character"] as? String
        self.tags = json["tags"] as? String
    }
}