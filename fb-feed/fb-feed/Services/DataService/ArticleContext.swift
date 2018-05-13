//
//  ArticleContext.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

struct ArticleContext {

    var articles = [Article]()
    var loadedPages = 0
    let to: Date

    init(to: Date) {
        self.to = to
    }

    mutating func appendPage(_ newArticles: [Article]) {
        loadedPages += 1
        articles.append(contentsOf: newArticles)
    }
    
}
