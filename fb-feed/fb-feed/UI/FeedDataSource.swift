//
//  FeedDataSource.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import UIKit

class FeedDataSource: NSObject, UITableViewDataSource {

    private let dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self)) as! ArticleCell
        let currentArticle = article(at: indexPath.row)
        cell.update(with: currentArticle)
        return cell
    }

}

private extension FeedDataSource {

    func article(at index: Int) -> Article {
        return dataService.articles[index]
    }

}
