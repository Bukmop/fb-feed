//
//  AdsService.swift
//  fb-feed
//
//  Created by Viktor Smidl on 13/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation
import FBAudienceNetwork

private let placementId = "620403288313161_620403514979805"

protocol AdsService {

    var ads: [Ad] { get }

}

class DefaultAdsService: NSObject, AdsService {

    private var nativeAd: FBNativeAd?

    private(set) var ads = [Ad]()

    override init() {
        super.init()

        let nativeAd = FBNativeAd(placementID: placementId)
        ads.append(Ad(fbNativeAd: nativeAd))
    }

}
