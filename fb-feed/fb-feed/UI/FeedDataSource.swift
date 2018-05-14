//
//  FeedDataSource.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

private let adIndex = 2

class FeedDataSource: NSObject {

    typealias OnDataAdded = ([IndexPath]) -> Void

    private let dataService: DataService
    private let adsService: AdsService
    private var dataServiceListener: DataServiceListener!
    private var items = [FeedItem]()
    private weak var controller: UIViewController?

    var onDataAdded: OnDataAdded?

    init(dataService: DataService, adsService: AdsService, controller: UIViewController?) {
        self.dataService = dataService
        self.adsService = adsService
        self.controller = controller

        super.init()
        setUpListener()
    }

}

extension FeedDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedItemCell.self)) as! FeedItemCell
        let currentItem = item(at: indexPath.row)
        cell.update(with: currentItem)

        if let adItem = currentItem as? Ad {
            adItem.fbNativeAd.unregisterView()
            adItem.fbNativeAd.registerView(forInteraction: cell, with: controller)

            adItem.onFBNativeAdLoad = { [weak tableView] _ in
                tableView?.reloadRows(at: [indexPath], with: .none)
            }
        }

        return cell
    }

}

private extension FeedDataSource {

    func setUpListener() {
        dataServiceListener = DataServiceListener(dataService, onArticlesAdd: { [weak self] in
            self?.onArticlesAdd()
        })
    }

    func item(at index: Int) -> FeedItem {
        return items[index]
    }

    func onArticlesAdd() {
        let oldItems = items
        items = dataService.articles

        if items.count >= adIndex,
            let ad = adsService.ads.first {
            items.insert(ad, at: adIndex)
        }

        let firstIndex = oldItems.count
        let lastIndex = items.count - 1

        guard firstIndex <= lastIndex else {
            return
        }

        let indexPaths = (firstIndex...lastIndex).map({ IndexPath(row: $0, section: 0) })
        onDataAdded?(indexPaths)
    }

}
