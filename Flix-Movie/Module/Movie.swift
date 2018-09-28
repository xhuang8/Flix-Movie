//
//  Movie.swift
//  Flix-Movie
//
//  Created by XiaoQian Huang on 9/27/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import Foundation

class Movie {
    
    var title: String
    var posterUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
    }
    
    
    
    
    
    
    
}
