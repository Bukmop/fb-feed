//
//  DataService.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

private let contextPageSize = 3

struct DataServiceNotifications {

    static let stateDidChange = NSNotification.Name(rawValue: "stateDidChange")
    static let articlesDidAdd = NSNotification.Name(rawValue: "articlesDidAdd")

}

enum DataServiceState {

    case readyToFetch
    case fetching
    case allFetched
    
}

protocol DataService {

    var articles: [Article] { get }
    var state: DataServiceState { get }

    func fetch()

}

class DefaultDataService: DataService {

    private let apiService: ApiService
    private var context: ArticleContext?

    private(set) var state = DataServiceState.readyToFetch {
        didSet {
            stateDidChange()
        }
    }

    init(apiService: ApiService) {
        self.apiService = apiService
    }

}

extension DefaultDataService {

    var articles: [Article] {
        return context?.articles ?? []
    }

    func fetch() {
        guard state.canFetch else {
            return
        }

        if context == nil {
            context = buildContext()
        }

        guard let context = context else {
            return
        }

        let request = TopHeadlinesRequest(
            to: context.to,
            pageSize: contextPageSize,
            page: context.loadedPages + 1
        )

        state = .fetching

        apiService.getTop(request) { [weak self] response in
            switch response {
            case let .data(topArticles):
                DispatchQueue.main.async {
                    guard let `self` = self else {
                        return
                    }

                    self.context?.appendPage(topArticles.articles)
                    self.articlesDidAdd()

                    let loadedArticlesCount = (self.context?.loadedPages ?? 0) * contextPageSize
                    self.state = loadedArticlesCount >= topArticles.totalResults
                        ? .allFetched
                        : .readyToFetch
                }
            case let .error(error):
                print("Getting top did fail")

                if let error = error {
                    print(error)
                }

                // TODO: Try again.
                DispatchQueue.main.async {
                    self?.state = .readyToFetch
                }
            }
        }
    }

}

private extension DefaultDataService {

    func stateDidChange() {
        NotificationCenter.default.post(name: DataServiceNotifications.stateDidChange, object: self)
    }

    func articlesDidAdd() {
        NotificationCenter.default.post(name: DataServiceNotifications.articlesDidAdd, object: self)
    }

}

private extension DefaultDataService {

    func buildContext() -> ArticleContext {
        return ArticleContext(to: Date())
    }

}

private extension DataServiceState {

    var canFetch: Bool {
        switch self {
        case .fetching, .allFetched:
            return false
        case .readyToFetch:
            return true
        }
    }

}
