import SwiftUI

struct RepositoryList: View {
    @ObservedObject private(set) var viewModel: RepositoryListViewModel

    var body: some View {
        VStack {
            NavigationStack {
                self.content.navigationTitle("GitHub").navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $viewModel.searchText)
        }
    }

    @ViewBuilder private var content: some View {
        if case let .loaded(result) = viewModel.status {
            List(result.items) { repo in
                RepositoryRow(repo: repo)
            }
        } else {
            Text(viewModel.statusMessage)
        }
    }
}

struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryList(viewModel: RepositoryListViewModel(service: SearchRepositoryService()))
    }
}
