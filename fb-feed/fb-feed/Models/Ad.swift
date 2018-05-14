//
//  Ad.swift
//  fb-feed
//
//  Created by Viktor Smidl on 13/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation
import FBAudienceNetwork

class Ad: NSObject {

    typealias OnFBNativeAdLoad = (Error?) -> Void

    private var remainingRetryCount = 3
    let fbNativeAd: FBNativeAd
    var onFBNativeAdLoad: OnFBNativeAdLoad?

    init(fbNativeAd: FBNativeAd) {
        self.fbNativeAd = fbNativeAd

        super.init()

        fbNativeAd.delegate = self
        fbNativeAd.load()
    }

}

extension Ad: FeedItem {

    var author: String? {
        return "Native Ads"
    }

    var title: String? {
        return fbNativeAd.title
    }

    var subtitle: String? {
        return fbNativeAd.body
    }

    var url: String? {
        return nil
    }

    var urlToImage: String? {
        return fbNativeAd.coverImage?.url.absoluteString
    }

}

extension Ad: FBNativeAdDelegate {

    func nativeAdDidLoad(_ nativeAd: FBNativeAd) {
        print("Native Ad loaded: \(nativeAd)")
        onFBNativeAdLoad?(nil)
    }

    func nativeAd(_ nativeAd: FBNativeAd, didFailWithError error: Error) {
        print("Native Ad error: \(error)")
        onFBNativeAdLoad?(error)
    }

}
