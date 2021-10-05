import Foundation

protocol APIRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

struct TheCharacterAPIRequest: APIRequest {
    
    var urlString: String
    var page: Int
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = [URLQueryItem(name: "page", value: String(page))]
        return URLRequest(url: urlComponents.url!)
    }
    func decodeResponse(data: Data) throws -> TheCharacter {
        let character = try JSONDecoder().decode(TheCharacter.self, from: data)
        return character
    }
    
}


