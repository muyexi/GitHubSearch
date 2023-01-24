import Foundation
import SwiftUI
import Combine

protocol SearchAPIProtocol {
    func search(query: String) -> AnyPublisher<SearchResult<Repository>, Error>
}

class SearchRepositoryService: ServiceProtocol {
    var baseURL: String {
        return "https://api.github.com/"
    }

    var path: String {
        return "search/repositories"
    }

    var method: String {
        return "GET"
    }

    var headers: [String: String]? {
        return ["Accept": "application/vnd.github+json"]
    }

    func search(query: String) -> AnyPublisher<SearchResult<Repository>, Error> {
        return request(params: ["q": query])
    }
}
