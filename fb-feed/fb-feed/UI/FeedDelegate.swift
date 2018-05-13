//
//  FeedDelegate.swift
//  fb-feed
//
//  Created by Viktor Smidl on 13/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

private let footerHeight: CGFloat = 40

class FeedDelegate: NSObject, UITableViewDelegate {

    private let dataService: DataService
    private var dataServiceListener: DataServiceListener!
    private weak var tableView: UITableView?

    init(dataService: DataService) {
        self.dataService = dataService

        super.init()
        setUpListener()
    }

}

extension FeedDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging,
            let tableView = tableView,
            let tableViewSuperview = tableView.superview,
            let footerView = footerView,
            tableView.frame.contains(tableViewSuperview.convert(footerView.frame, from: footerView.superview)) {
            dataService.fetch()
        }
    }

}

extension FeedDelegate {

    func register(with tableView: UITableView) {
        self.tableView = tableView

        tableView.tableFooterView = UINib(nibName: LoadingFooterView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView
        updateFooter()
    }

}

private extension FeedDelegate {

    var footerView: LoadingFooterView? {
        return tableView?.tableFooterView as? LoadingFooterView
    }

    func setUpListener() {
        dataServiceListener = DataServiceListener(dataService, onStateChange: { [weak self] in
            self?.updateFooter()
        })
    }

    func updateFooter() {
        footerView?.update(with: dataService.loadingFooterState)
    }

}

private extension DataService {

    var loadingFooterState: LoadingFooterView.State {
        switch state {
        case .readyToFetch:
            return .readyToLoad
        case .fetching:
            return .loading
        case .allFetched:
            return .nothingToLoad
        }
    }

}
