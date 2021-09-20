import Foundation
import UIKit

class ApiRequestsController {
    static let shared = ApiRequestsController()
    
    let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    
    func fetchCharacters(completion: @escaping (Result<[TheCharacter], Error>) -> Void) {
        var charactersPageNumberQuery = 1
        while charactersPageNumberQuery <= 34 { // 34 - because it's almost 34 pages in API
            var urlComponents = URLComponents(url: baseURL.appendingPathComponent("character"), resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = ["page": String(charactersPageNumberQuery)].map { URLQueryItem(name: $0.key, value: $0.value)}
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
        var locationsPageNumberQuery = 1
        let locationsURL = baseURL.appendingPathComponent("location")
        while locationsPageNumberQuery <= 8 {
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
            locationsPageNumberQuery += 1
        }
        
    }
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        var episodesPageNumberQuery = 1
        let episodesURL = baseURL.appendingPathComponent("episode")
        while episodesPageNumberQuery <= 3 {
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
            episodesPageNumberQuery += 1
        }
        
    }
    
}
