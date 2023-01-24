import Foundation

struct SearchResult<Type: Codable>: Codable {
    var totalCount: Int
    var items: [Type]
}

struct Repository: Codable, Identifiable {
    var id: Int
    var name: String
    var fullName: String
    var language: String?
    var description: String?
    var htmlUrl: String
    var stargazersCount: Int

    var owner: Owner

    var formattedStarCount: String {
        if stargazersCount >= 1000 {
            return String(format: "$%.1fK", Float(stargazersCount) / 1000)
        } else {
            return stargazersCount.description
        }
    }

    struct Owner: Codable {
        var login: String
        var avatarUrl: String
    }
}
