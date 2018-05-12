//
//  DataServiceListener.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

class DataServiceListener {

    typealias OnDataChange = () -> Void

    private let dataService: DataService
    private let onDataChange: OnDataChange

    init(_ dataService: DataService, onDataChange: @escaping OnDataChange) {
        self.onDataChange = onDataChange
        self.dataService = dataService

        NotificationCenter.default.addObserver(self, selector: #selector(articlesDidChange), name: DataServiceNotifications.articlesDidChange, object: nil)
    }

}

extension DataServiceListener {

    @objc func articlesDidChange(notification: Notification) {
        onDataChange()
    }

}
