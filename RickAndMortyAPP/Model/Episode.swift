import Foundation

struct Episode: Codable {
    var id: Int
    var name: String
    var airDate: String
    var episodeSerialName: String
    var characters: [URL]
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episodeSerialName = "episode"
        case characters
        case url
    }
}

extension Episode {
    static let episodesURLStrings: [String: [String]] = [
        "season1": ["https://rick-i-morty.online/episodes/1sez-1seriya1506/", "https://rick-i-morty.online/episodes/1sez-2seriya201/", "https://rick-i-morty.online/episodes/1sez-3seriya147/", "https://rick-i-morty.online/episodes/1sez-4seriya127/", "https://rick-i-morty.online/episodes/1sez-5seriya136/", "https://rick-i-morty.online/episodes/1sez-6seriya123/", "https://rick-i-morty.online/episodes/1sez-7seriya128/", "https://rick-i-morty.online/episodes/1sez-8seriya130/", "https://rick-i-morty.online/episodes/1sez-9seriya124/", "https://rick-i-morty.online/episodes/1sez-10seriya130/", "https://rick-i-morty.online/episodes/1sez-11seriya133/"],
        
        "season2": ["https://rick-i-morty.online/episodes/2sez-1seriya161/", "https://rick-i-morty.online/episodes/2sez-2seriya158/", "https://rick-i-morty.online/episodes/2sez-3seriya117/", "https://rick-i-morty.online/episodes/2sez-4seriya113/", "https://rick-i-morty.online/episodes/2sez-5seriya123/", "https://rick-i-morty.online/episodes/2sez-6seriya134/", "https://rick-i-morty.online/episodes/2sez-7seriya114/", "https://rick-i-morty.online/episodes/2sez-8seriya113/", "https://rick-i-morty.online/episodes/2sez-9seriya113/", "https://rick-i-morty.online/episodes/2sez-10seriya113/"],
        
        "season3": ["https://rick-i-morty.online/episodes/3sez-1seriya161/", "https://rick-i-morty.online/episodes/3sez-2seriya158/", "https://rick-i-morty.online/episodes/3sez-3seriya119/", "https://rick-i-morty.online/episodes/3sez-4seriya137/", "https://rick-i-morty.online/episodes/3sez-5seriya118/", "https://rick-i-morty.online/episodes/3sez-6seriya113/", "https://rick-i-morty.online/episodes/3sez-7seriya115/", "https://rick-i-morty.online/episodes/3sez-8seriya115/", "https://rick-i-morty.online/episodes/3sez-9seriya113/", "https://rick-i-morty.online/episodes/3sez-10seriya113/"],
        
        "season4": ["https://rick-i-morty.online/episodes/4sez-1seriya168/", "https://rick-i-morty.online/episodes/4sez-2seriya158/", "https://rick-i-morty.online/episodes/4sez-3seriya118/", "https://rick-i-morty.online/episodes/4sez-4seriya115/", "https://rick-i-morty.online/episodes/4sez-5seriya124/", "https://rick-i-morty.online/episodes/4sez-6seriya113/", "https://rick-i-morty.online/episodes/4sez-7seriya115/", "https://rick-i-morty.online/episodes/4sez-8seriya120/", "https://rick-i-morty.online/episodes/4sez-9seriya114/", "https://rick-i-morty.online/episodes/4sez-10seriya114/"],
        
        "season5": ["https://rick-i-morty.online/episodes/5sez-1seriya118/",
                    "https://rick-i-morty.online/episodes/5sez-2seriya8/",
                    "https://rick-i-morty.online/episodes/5sez-3seriya47/",
                    "https://rick-i-morty.online/episodes/5sez-4seriya41/",
                    "https://rick-i-morty.online/episodes/5sez-5seriya52/",
                    "https://rick-i-morty.online/episodes/5sez-6seriya53/",
                    "https://rick-i-morty.online/episodes/5sez-7seriya59/",
                    "https://rick-i-morty.online/episodes/5sez-8seriya53/",
                    "https://rick-i-morty.online/episodes/5sez-9-seriya36/",
                    "https://rick-i-morty.online/episodes/5sez-10-seriya15/"]
    ]
}

extension Episode: Comparable {
    static func <(rhs: Episode, lhs: Episode) -> Bool {
        return rhs.id < lhs.id
    }
}
