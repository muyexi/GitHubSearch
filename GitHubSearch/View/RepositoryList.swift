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
        switch viewModel.status {
        case .none:
            Text("Type to search Repositories")
        case .loading:
            Text("Searching for \(viewModel.searchText)...")
        case let .loaded(result):
            List(result.items) { repo in
                RepositoryRow(repo: repo)
            }
        case let .failed(error):
            Text("An Error Occured: \(error.localizedDescription)")
        }
    }
}

struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryList(viewModel: RepositoryListViewModel())
    }
}
