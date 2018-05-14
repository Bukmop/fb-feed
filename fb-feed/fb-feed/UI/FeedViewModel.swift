//
//  FeedViewModel.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

protocol FeedViewModelDelegate: class {

    var controller: UIViewController { get }

    func onDataAdded(_ indexPaths: [IndexPath])

}

class FeedViewModel {

    private let dataService: DataService

    let feedDataSource: FeedDataSource
    let feedDelegate: FeedDelegate

    weak var delegate: FeedViewModelDelegate?

    init(dataService: DataService, adsService: AdsService) {
        self.dataService = dataService
        feedDelegate = FeedDelegate(dataService: dataService)
        feedDataSource = FeedDataSource(
            dataService: dataService,
            adsService: adsService,
            controller: delegate?.controller
        )

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
