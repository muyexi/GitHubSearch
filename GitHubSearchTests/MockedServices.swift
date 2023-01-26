import XCTest
import Combine

@testable import GitHubSearch

class MockedSearchErrorService: SearchRepositoryService {
    let error: Error

    init(error: Error) {
        self.error = error
    }

    override func search(query: String) -> AnyPublisher<SearchResult<Repository>, Error> {
        return Fail<SearchResult<Repository>, Error>(error: error).eraseToAnyPublisher()
    }
}

class MockedSearchResultService: SearchRepositoryService {
    let result: SearchResult<Repository>
    let delay: TimeInterval

    init(result: SearchResult<Repository>, delay: TimeInterval = 0) {
        self.result = result
        self.delay = delay
    }

    override func search(query: String) -> AnyPublisher<SearchResult<Repository>, Error> {
        if delay == 0 {
            return Just(result)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Just(result)
                .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
