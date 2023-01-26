import Foundation

struct SearchResult<Type: Codable & Equatable>: Codable, Equatable {
    var totalCount: Int
    var items: [Type]

    static func == (lhs: SearchResult<Type>, rhs: SearchResult<Type>) -> Bool {
        return lhs.items == rhs.items
    }
}

struct Repository: Codable, Identifiable, Equatable {
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

    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}
