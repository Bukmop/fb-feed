//
//  FeedItem.swift
//  fb-feed
//
//  Created by Viktor Smidl on 13/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation
import FBAudienceNetwork

protocol FeedItem {

    var author: String? { get }
    var title: String? { get }
    var subtitle: String? { get }
    var url: String? { get }
    var urlToImage: String? { get }

}
