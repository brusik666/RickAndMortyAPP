import Foundation

struct Location: Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [URL]
    var url: URL
}

extension Location: Comparable {
    
    static func <(lhs: Location, rhs: Location) -> Bool {
        return lhs.id < rhs.id
    }
}


