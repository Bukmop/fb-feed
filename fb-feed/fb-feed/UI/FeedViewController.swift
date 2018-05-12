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
        dataService: DefaultDataService(apiService: DefaultApiService())
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        tableView.dataSource = viewModel.feedDataSource
        viewModel.viewDidLoad()
    }

}

extension FeedViewController: FeedViewModelDelegate {

    func dataDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
