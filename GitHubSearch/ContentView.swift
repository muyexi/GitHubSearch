import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: RepositoryListViewModel = RepositoryListViewModel()
    
    var body: some View {
        RepositoryList(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
