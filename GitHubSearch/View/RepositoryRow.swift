import SwiftUI

struct RepositoryRow: View {
    var repo: Repository = Repository(id: 75287738,
                                      name: "ios",
                                      fullName: "nextcloud/ios",
                                      language: "Swift",
                                      description: "📱 Nextcloud iOS App",
                                      htmlURL: "https://github.com/nextcloud/ios",
                                      starCount: 1457,
                                      owner: "nextcloud",
                                      avatarURL: "https://avatars.githubusercontent.com/u/19211038?v=4"
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: repo.avatarURL))
                { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 25, height: 25)
                .clipShape(Circle())
                Text(repo.owner).font(.subheadline)
                Spacer()
            }

            Text(repo.name).font(.title3)
            Text(repo.description)
            HStack(alignment: .center, spacing: 20.0) {
                HStack(spacing: 5.0) {
                    Image(systemName: "star")
                    Text(repo.formattedStarCount)
                }
                HStack(spacing: 5.0) {
                    Image(systemName: "pencil.circle")
                    Text(repo.language)
                }
            }.font(.subheadline)
        }
        .padding(.leading)
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow().previewLayout(.fixed(width: 300, height: 150))
    }
}
