import SwiftUI

struct RepositoryList: View {
    var body: some View {
        List() {
            RepositoryRow()
            RepositoryRow()
            RepositoryRow()
            RepositoryRow()
            RepositoryRow()
        }
    }
}

struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryList()
    }
}
