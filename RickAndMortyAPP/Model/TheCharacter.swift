import Foundation

struct TheCharacter: Codable {
    var id: Int
    var status: String
    var name: String
    var imageURL: String
    var species: String
    var gender: String
    var originLocation: [String: String]
    var lastKnownLocation: [String: String]
 //   var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case name
        case imageURL = "image"
        case species
        case gender
        case originLocation = "origin"
        case lastKnownLocation = "location"
  //      case url
    }
}
