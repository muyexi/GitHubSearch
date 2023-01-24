import SwiftUI
import Combine

enum LoadingStatus<T> {
    case none
    case loading
    case loaded(T)
    case failed(Error)
}

class RepositoryListViewModel: ObservableObject {
    @Published var status: LoadingStatus<SearchResult<Repository>> = .none
    @Published var searchText: String = ""

    private var cancelBag = Set<AnyCancellable>()

    init() {
        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { query in
                do {
                    try self.search(query: query)
                } catch let error {
                    return self.status = .failed(error)
                }
            }
            .store(in: &cancelBag)
    }

    func search(query: String) throws {
        switch status {
        case .none:
            status = .loading
        default:
            break
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let request = try createRequest(
            baseURL: "https://api.github.com/search/repositories", params: ["q": query])
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: SearchResult<Repository>.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    print("Received completion: \($0).")
                },
                receiveValue: { result in
                    self.status = .loaded(result)
                }
            ).store(in: &cancelBag)
    }

    func createRequest(baseURL: String, params: [String: String]) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        components.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Accept": "application/vnd.github+json"]

        return request
    }
}
