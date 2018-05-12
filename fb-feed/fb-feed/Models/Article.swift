//
//  Article.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

struct Article: Decodable {

    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    
}
