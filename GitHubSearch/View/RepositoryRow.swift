import SwiftUI

struct RepositoryRow: View {
    var repo: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: repo.owner.avatarUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 25, height: 25)
                .clipShape(Circle())
                Text(repo.owner.login).font(.subheadline)
                Spacer()
            }

            Text(repo.name).font(.title3)
            Text(repo.description ?? "").lineLimit(2)
            HStack(alignment: .center, spacing: 20.0) {
                HStack(spacing: 5.0) {
                    Image(systemName: "star")
                    Text(repo.formattedStarCount)
                }
                HStack(spacing: 5.0) {
                    Image(systemName: "pencil.circle")
                    Text(repo.language ?? "")
                }
            }.font(.subheadline)
        }
        .padding(.leading)
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(repo: Repository.mockedData).previewLayout(.fixed(width: 300, height: 150))
    }
}
