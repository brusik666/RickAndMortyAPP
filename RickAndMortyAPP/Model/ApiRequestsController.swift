import Foundation
import UIKit

class ApiRequestsController: DataBaseAvailable {
    static let shared = ApiRequestsController()
    static let charactersStringURL = "https://rickandmortyapi.com/api/character"
    
    let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    let jsonDecoder = JSONDecoder()
    
    func fetchSingleCharacter(url: URL, completion: @escaping (Result<TheCharacter, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            if let data = data {
                do {
                    let character = try self.jsonDecoder.decode(TheCharacter.self, from: data)
                    completion(.success(character))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
 
    func fetchCharacters(completion: @escaping (Result<[TheCharacter], Error>) -> Void) {
        var charactersPageNumberQuery = 1
        while charactersPageNumberQuery <= 42 {
            var urlComponents = URLComponents(url: baseURL.appendingPathComponent("character"), resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = ["page": String(charactersPageNumberQuery)].map { URLQueryItem(name: $0.key, value: $0.value)}
            let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
                if let data = data {
                    do {
                        let charactersResponse = try self.jsonDecoder.decode(CharactersResponse.self, from: data)
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
        
    func fetchCharactersImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
        return task
    }
    
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        var locationsPageNumberQuery = 0
        let locationsURL = baseURL.appendingPathComponent("location")
        while locationsPageNumberQuery <= 8 {
            var urlComponents = URLComponents(url: locationsURL, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = ["page": String(locationsPageNumberQuery)].map {URLQueryItem(name: $0.key, value: $0.value)}
            let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
                if let data = data {
                    do {
                        let locationsResponse = try self.jsonDecoder.decode(LocationsResponse.self, from: data)
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
            var urlComponents = URLComponents(url: episodesURL, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = ["page": String(episodesPageNumberQuery)].map {URLQueryItem(name: $0.key, value: $0.value)}
            let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
                if let data = data {
                    do {
                        let episodesResponse = try self.jsonDecoder.decode(EpisodesResponse.self, from: data)
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
