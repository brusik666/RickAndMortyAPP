import Foundation

struct CharactersResponse: Codable {
    let results: [TheCharacter]
}

struct LocationsResponse: Codable {
    let results: [Location]
}

struct EpisodesResponse: Codable {
    let results: [Episode]
}
