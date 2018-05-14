//
//  ViewController.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private let viewModel = FeedViewModel(
        dataService: DefaultDataService(apiService: DefaultApiService()),
        adsService: DefaultAdsService()
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Facebook Feed"
        viewModel.delegate = self

        let feedDelegate = viewModel.feedDelegate
        feedDelegate.register(with: tableView)
        tableView.delegate = feedDelegate

        tableView.dataSource = viewModel.feedDataSource
        viewModel.viewDidLoad()
    }

}

extension FeedViewController: FeedViewModelDelegate {

    var controller: UIViewController {
        return self
    }

    func onDataAdded(_ indexPaths: [IndexPath]) {
        tableView.insertRows(at: indexPaths, with: .none)
    }

}
