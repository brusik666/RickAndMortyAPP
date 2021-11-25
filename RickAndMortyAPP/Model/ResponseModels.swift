import Foundation

struct CharactersResponse: Codable {
    var results: [TheCharacter]
    
}

struct LocationsResponse: Codable {
    var results: [Location]
}

struct EpisodesResponse: Codable {
    var results: [Episode]
}

/*struct JSONResponse: Codable, ApiRequest {
    var results: Codable
    
}*/
