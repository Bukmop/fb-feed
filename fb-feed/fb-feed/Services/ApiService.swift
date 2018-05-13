//
//  ApiService.swift
//  fb-feed
//
//  Created by Viktor Smidl on 12/05/2018.
//  Copyright © 2018 viktor smidl. All rights reserved.
//

import Foundation

private let apiKey = "4e50b6d025f64402b0d0d2f7bde2b7db"
private let apiDateFormat = "YYYY-MM-DD'T'HH:mm:ss"

typealias ApiCallback<T> = (ApiResponse<T>) -> Void

enum ApiResponse<T> {
    case data(T)
    case error(Error?)
}

enum ApiServiceError: Error {
    case canNotBuildUrl
    case missingResponseData
    case canNotParseResponse(Error)
}

protocol ApiService {

    func getTop(_ request: TopHeadlinesRequest, callback: @escaping ApiCallback<TopArticles>)

}

class DefaultApiService: ApiService {

    private var defaultSession = URLSession(configuration: .default)

}

extension DefaultApiService {

    func getTop(_ request: TopHeadlinesRequest, callback: @escaping ApiCallback<TopArticles>) {
        guard var components = URLComponents(string: "https://newsapi.org/v2/top-headlines") else {
            callback(.error(ApiServiceError.canNotBuildUrl))
            return
        }

        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "q", value: "facebook"),
            URLQueryItem(name: "to", value: request.to.toString(apiDateFormat)),
            URLQueryItem(name: "pageSize", value: String(request.pageSize)),
            URLQueryItem(name: "page", value: String(request.page))
        ]

        guard let url = components.url else {
            callback(.error(ApiServiceError.canNotBuildUrl))
            return
        }

        print("Getting top: \(url)")

        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                callback(.error(error))
                return
            }

            guard let data = data else {
                callback(.error(ApiServiceError.missingResponseData))
                return
            }

            print(String(data: data, encoding: String.Encoding.utf8) ?? "")
            print("\n")

            do {
                let articles = try JSONDecoder().decode(TopArticles.self, from: data)
                callback(.data(articles))
            } catch {
                callback(.error(ApiServiceError.canNotParseResponse(error)))
            }
        }

        task.resume()
    }

}
