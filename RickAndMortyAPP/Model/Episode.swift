import Foundation

struct Episode: Codable {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [URL]
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
    }
}
