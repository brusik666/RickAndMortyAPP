import Foundation
import UIKit

class ApiRequestsController {
    static let shared = ApiRequestsController()
    
    let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    
    func fetchCharacters(completion: @escaping (Result<[TheCharacter], Error>) -> Void) {
 //       let charactersURL = baseURL.appendingPathComponent("character")
        var charactersPageNumberQuery = 1
        while charactersPageNumberQuery <= 34 { // 34 - because
            var urlComponents = URLComponents(url: baseURL.appendingPathComponent("character"), resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = ["page": String(charactersPageNumberQuery)].map {URLQueryItem(name: $0.key, value: $0.value)}
            let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let charactersResponse = try jsonDecoder.decode(CharactersResponse.self, from: data)
                        completion(.success(charactersResponse.results))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
            task.resume()
            charactersPageNumberQuery += 1
        }
    }
        
    
    enum ChatacterInfoError: Error, LocalizedError {
        case imageDataMissing
    }
    
    

    func fetchCharactersImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        let locationsURL = baseURL.appendingPathComponent("location")
        let task = URLSession.shared.dataTask(with: locationsURL) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let locationsResponse = try jsonDecoder.decode(LocationsResponse.self, from: data)
                    completion(.success(locationsResponse.results))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        let episodesURL = baseURL.appendingPathComponent("episode")
        let task = URLSession.shared.dataTask(with: episodesURL) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let episodesResponse = try jsonDecoder.decode(EpisodesResponse.self, from: data)
                    completion(.success(episodesResponse.results))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
