import SwiftUI

struct RepositoryRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/19211038?v=4"))
                { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 25, height: 25)
                .clipShape(Circle())
                Text("nextcloud").font(.subheadline)
                Spacer()
            }

            Text("ios").font(.title3)
            Text("📱 Nextcloud iOS App")
            HStack(alignment: .center, spacing: 20.0) {
                HStack(spacing: 5.0) {
                    Image(systemName: "star")
                    Text("1.5k")
                }
                HStack(spacing: 5.0) {
                    Image(systemName: "pencil.circle")
                    Text("Swift")
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
