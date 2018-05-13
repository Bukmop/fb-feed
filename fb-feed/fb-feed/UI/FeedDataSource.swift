//
//  FeedDataSource.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

class FeedDataSource: NSObject {

    typealias OnDataAdded = ([IndexPath]) -> Void

    private let dataService: DataService
    private var dataServiceListener: DataServiceListener!
    private var articles = [Article]()

    var onDataAdded: OnDataAdded?

    init(dataService: DataService, onDataAdded: OnDataAdded? = nil) {
        self.dataService = dataService
        self.onDataAdded = onDataAdded

        super.init()
        setUpListener()
    }

}

extension FeedDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self)) as! ArticleCell
        let currentArticle = article(at: indexPath.row)
        cell.update(with: currentArticle)
        return cell
    }

}

private extension FeedDataSource {

    func setUpListener() {
        dataServiceListener = DataServiceListener(dataService, onArticlesAdd: { [weak self] in
            self?.onArticlesAdd()
        })
    }

    func article(at index: Int) -> Article {
        return articles[index]
    }

    func onArticlesAdd() {
        let oldArticles = articles
        articles = dataService.articles

        let firstIndex = oldArticles.count
        let lastIndex = articles.count - 1

        guard firstIndex <= lastIndex else {
            return
        }

        let indexPaths = (firstIndex...lastIndex).map({ IndexPath(row: $0, section: 0) })
        onDataAdded?(indexPaths)
    }

}
