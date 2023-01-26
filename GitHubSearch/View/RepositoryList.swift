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
        case .loading:
            Text(viewModel.statusMessage)
            ProgressView()
        case let .loaded(result):
            List(result.items) { repo in
                RepositoryRow(repo: repo)
            }
            Text(viewModel.statusMessage).font(.footnote).foregroundColor(.gray)
        default:
            Text(viewModel.statusMessage)
        }
    }
}

struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryList(viewModel: RepositoryListViewModel(service: SearchRepositoryService()))
    }
}
