import Foundation

struct TheCharacter: Codable {
    
    let uuid = UUID()
    var status: String
    var name: String
    var imageURL: URL
    var species: String
    var gender: String
    var originLocation: [String: String]
    var lastKnownLocation: [String: String]
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case status
        case name
        case imageURL = "image"
        case species
        case gender
        case originLocation = "origin"
        case lastKnownLocation = "location"
        case url
    }
}

extension TheCharacter: Hashable {
    
    static func ==(lhs: TheCharacter, rhs: TheCharacter) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

enum Section: Hashable {
    case main
}





