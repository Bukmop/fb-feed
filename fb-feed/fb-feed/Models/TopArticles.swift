//
//  TopArticles.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

struct TopArticles: Decodable {

    let status: String
    let articles: [Article]

}
