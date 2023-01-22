import SwiftUI
import Combine

enum LoadingStatus {
    case none
    case loading
    case loaded
    case failed
}

class RepositoryListViewModel: ObservableObject {
    @Published var status: LoadingStatus = .none
    @Published var searchText: String = ""

    private var cancelBag = Set<AnyCancellable>()

    init() {
        $searchText
            .filter { !$0.isEmpty }
            .throttle(for: .seconds(2), scheduler: RunLoop.main, latest: true)
            .sink { _ in
                self.status = .loading

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                    status = .loaded
                }
            }
            .store(in: &cancelBag)
    }
}
