import XCTest
@testable import GitHubSearch

final class GitHubSearchTests: XCTestCase {
    private let debouceDelay: TimeInterval = 0.5
    private var mockedResult = SearchResult(totalCount: 1, items: [Repository.mockedData])

    func test_not_loaded() throws {
        let service = MockedSearchResultService(result: mockedResult)
        let viewModel = RepositoryListViewModel(service: service)
        viewModel.searchText = ""
        
        XCTAssertEqual(viewModel.statusMessage, "Type to search")
    }
        
    func test_loading() throws {
        let service = MockedSearchResultService(result: mockedResult, delay: 5)
        
        let viewModel = RepositoryListViewModel(service: service)
        viewModel.searchText = "iOS"

        wait(timeInSeconds: debouceDelay)
        XCTAssertEqual(viewModel.statusMessage, "Searching for \(viewModel.searchText)...")
    }
    
    func test_loaded() throws {
        let service = MockedSearchResultService(result: mockedResult)
        
        let viewModel = RepositoryListViewModel(service: service)
        viewModel.searchText = "iOS"
        
        wait(timeInSeconds: debouceDelay)
        XCTAssertTrue(mockedResult == viewModel.status.value)
    }
    
    func test_loading_failed() throws {
        let error = URLError(.badServerResponse)
        let service = MockedSearchErrorService(error: error)
        
        let viewModel = RepositoryListViewModel(service: service)
        viewModel.searchText = "iOS"
        
        wait(timeInSeconds: debouceDelay)
        XCTAssertEqual(viewModel.statusMessage, "An Error Occured: \(error.localizedDescription)")
    }
        
    func wait(timeInSeconds: TimeInterval) {
        let expectation = XCTestExpectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)
    }
}
