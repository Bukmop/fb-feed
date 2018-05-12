//
//  DataService.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

private let contextPageSize = 5

private struct ArticleContext {
    var articles = [Article]()
    var loadedPages = 0
    let to: Date

    init(to: Date) {
        self.to = to
    }

    mutating func appendPage(_ newArticles: [Article]) {
        loadedPages += 1
        articles.append(contentsOf: newArticles)
    }
}

protocol DataService {

    var articles: [Article] { get }

    func fetch()

}

class DefaultDataService: DataService {

    private let apiService: ApiService
    private var context: ArticleContext?

    init(apiService: ApiService) {
        self.apiService = apiService
    }

}

extension DefaultDataService {

    var articles: [Article] {
        return context?.articles ?? []
    }

    func fetch() {
        if context == nil {
            context = buildContext()
        }

        guard let context = context else {
            return
        }

        let request = TopHeadlinesRequest(
            to: context.to,
            pageSize: contextPageSize,
            page: context.loadedPages
        )

        apiService.getTop(request) { [weak self] response in
            switch response {
            case let .data(newArticles):
                self?.context?.appendPage(newArticles)
            case let .error(error):
                print("Getting top did fail")

                if let error = error {
                    print(error)
                }

                // TODO: Try again.
            }
        }

    }

}

private extension DefaultDataService {

    func buildContext() -> ArticleContext {
        return ArticleContext(to: Date())
    }

}
