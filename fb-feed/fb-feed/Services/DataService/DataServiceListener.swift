//
//  DataServiceListener.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

class DataServiceListener {

    typealias OnStateChange = () -> Void
    typealias OnArticlesAdd = () -> Void

    private let dataService: DataService
    private let onStateChange: OnStateChange?
    private let onArticlesAdd: OnArticlesAdd?

    init(_ dataService: DataService,
         onStateChange: OnStateChange? = nil,
         onArticlesAdd: OnArticlesAdd? = nil) {
        self.onStateChange = onStateChange
        self.onArticlesAdd = onArticlesAdd
        self.dataService = dataService

        NotificationCenter.default.addObserver(self, selector: #selector(stateDidChange), name: DataServiceNotifications.stateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(articlesDidAdd), name: DataServiceNotifications.articlesDidAdd, object: nil)
    }

}

extension DataServiceListener {

    @objc func stateDidChange(notification: Notification) {
        onStateChange?()
    }

    @objc func articlesDidAdd(notification: Notification) {
        onArticlesAdd?()
    }

}
