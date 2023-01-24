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

    let service: SearchRepositoryService
    private var cancelBag = Set<AnyCancellable>()

    init(service: SearchRepositoryService) {
        self.service = service

        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { query in
                self.search(query: query)
            }
            .store(in: &cancelBag)
    }

    func search(query: String) {
        if case .none = status {
            status = .loading
        }

        service.search(query: query)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.status = LoadingStatus.failed(error)
                }
            } receiveValue: { result in
                self.status = LoadingStatus.loaded(result)
            }.store(in: &cancelBag)
    }
}
