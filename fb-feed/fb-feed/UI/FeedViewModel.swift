//
//  FeedViewModel.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate: class {

    func onDataAdded(_ indexPaths: [IndexPath])

}

class FeedViewModel {

    private let dataService: DataService

    let feedDataSource: FeedDataSource
    let feedDelegate: FeedDelegate

    weak var delegate: FeedViewModelDelegate?

    init(dataService: DataService) {
        self.dataService = dataService
        feedDelegate = FeedDelegate(dataService: dataService)
        feedDataSource = FeedDataSource(dataService: dataService)

        feedDataSource.onDataAdded = { [weak self] indexPaths in
            self?.delegate?.onDataAdded(indexPaths)
        }
    }
}

extension FeedViewModel {

    func viewDidLoad() {
        dataService.fetch()
    }

}
