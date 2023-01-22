import Foundation

struct Repository: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var fullName: String
    var language: String
    var description: String
    var htmlURL: String
    var starCount: Int
    
    var owner: String
    var avatarURL: String
    
    var formattedStarCount: String {
        if starCount >= 1000 {
            return String(format: "$%.1fK", Float(starCount) / 1000)
        } else {
            return String(format: "$%.0f", starCount)
        }
    }
}
