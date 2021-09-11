import Foundation

class ApiRequestsController {
    static let shared = ApiRequestsController()
    
    let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    
    func fetchCharacters(completion: @escaping (Result<[TheCharacter], Error>) -> Void) {
        let charactersURL = baseURL.appendingPathComponent("character")
        print(charactersURL)
        let task = URLSession.shared.dataTask(with: charactersURL) { data, response, error in
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
