//
//  FeedViewModel.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate: class {

    func dataDidChange()

}

class FeedViewModel {

    private let dataService: DataService
    private var dataServiceListener: DataServiceListener!

    let feedDataSource: FeedDataSource

    weak var delegate: FeedViewModelDelegate?

    init(dataService: DataService) {
        self.dataService = dataService
        feedDataSource = FeedDataSource(dataService: dataService)

        setUpListener()
    }

    func setUpListener() {
        dataServiceListener = DataServiceListener(dataService, onDataChange: { [weak self] in
            self?.delegate?.dataDidChange()
        })
    }

    func viewDidLoad() {
        dataService.fetch()
    }

}
