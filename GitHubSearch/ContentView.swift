import SwiftUI

struct ContentView: View {
    var body: some View {
        RepositoryList(viewModel: RepositoryListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
