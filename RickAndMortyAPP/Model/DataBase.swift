//
//  DataBase.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 15.12.2021.
//

import Foundation
import UIKit

class DataBase: NetworkManagerAvailable {

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let imagesArchiveURL = documentsDirectory.appendingPathComponent("charactersImages").appendingPathExtension("plist")
    static let charactersArchiveURL = documentsDirectory.appendingPathComponent("characters").appendingPathExtension("plist")
    static let locationsArchiveURL = documentsDirectory.appendingPathComponent("locations").appendingPathExtension("plist")
    static let episodesArchiveURL = documentsDirectory.appendingPathComponent("episodes").appendingPathExtension("plist")
    
    private(set) var allCharacters: [TheCharacter]!
    private(set) var allEpisodes: [Episode]!
    private(set) var allLocations: [Location]!
    lazy var allImages: [String: Data]? = loadImagesFromMemory() {
        didSet {
            saveDataToMemory(data: allImages, in: DataBase.imagesArchiveURL)
        }
    }
    lazy var filteredCharacters: [TheCharacter] = self.allCharacters
    lazy var episodesBySeasons: [[Episode]] = {
        
        var season1 = [Episode]()
        var season2 = [Episode]()
        var season3 = [Episode]()
        var season4 = [Episode]()
        var season5 = [Episode]()
        
        allEpisodes.forEach { episode in
            if episode.episodeSerialName.contains("S01") {
                season1.append(episode)
            } else if episode.episodeSerialName.contains("S02") {
                season2.append(episode)
            } else if episode.episodeSerialName.contains("S03") {
                season3.append(episode)
            } else if episode.episodeSerialName.contains("S04"){
                season4.append(episode)
            } else if episode.episodeSerialName.contains("S05"){
                season5.append(episode)
            }
        }
        let allSeasons = [season1, season2, season3, season4, season5]
        return allSeasons
    }()
    
    private lazy var propertyListDecoder = PropertyListDecoder()
    
    func loadAllData() {
        getAllcharacters()
        getAllEpisodes()
        getAllLocations()
    }
    
    func addImageData(withName name: String, imageData: Data) {
        allImages?[name] = imageData
    }
    
    private func saveDataToMemory<T: Codable>(data: T, in path: URL) {
        let propertyListEncoder = PropertyListEncoder()
        let codedData = try? propertyListEncoder.encode(data)
        try? codedData?.write(to: path, options: .noFileProtection)
    }
    
    private func loadImagesFromMemory() -> Dictionary<String, Data>? {
        guard let codedImagesData = try? Data(contentsOf: DataBase.imagesArchiveURL) else { return nil }
        let allImagesDict = try? propertyListDecoder.decode(Dictionary<String, Data>.self , from: codedImagesData)
        return allImagesDict
    }
    
    private func loadCharactersFromMemory() -> [TheCharacter]? {
        guard let codedCharactersData = try? Data(contentsOf: DataBase.charactersArchiveURL),
              let characters = try? propertyListDecoder.decode([TheCharacter].self , from: codedCharactersData) else { return nil }
        return characters
    }
    
    private func loadLocationsFromMemory() -> [Location]? {
        guard let codedLocationsData = try? Data(contentsOf: DataBase.locationsArchiveURL) else { return nil }
        let locations = try? propertyListDecoder.decode([Location].self , from: codedLocationsData)
        return locations
    }
    
    private func loadEpisodesFromMemory() -> [Episode]? {
        guard let codedEpisodesData = try? Data(contentsOf: DataBase.episodesArchiveURL) else { return nil }
        let episodes = try? propertyListDecoder.decode([Episode].self , from: codedEpisodesData)
        return episodes
    }

    private func getAllcharacters() {
        if let savedCharacters = loadCharactersFromMemory() {
            allCharacters = savedCharacters
        } else {
            allCharacters = [TheCharacter]()
            networkManager?.fetchCharacters(completion: { result in
                switch result {
                case .success(let characters):
                    self.allCharacters.append(contentsOf: characters)
                    
                case .failure(let error):
                    print(error)
                }
                self.saveDataToMemory(data: self.allCharacters, in: DataBase.charactersArchiveURL)
            })
            
        }
    }

    
    private func getAllEpisodes() {
        if let savedEpisodes = loadEpisodesFromMemory() {
            allEpisodes = savedEpisodes
        } else {
            allEpisodes = [Episode]()
            networkManager?.fetchEpisodes(completion: { result in
                switch result {
                case .success(let episodes):
                    self.allEpisodes.append(contentsOf: episodes)
                case .failure(let error):
                    print(error)
                }
                self.saveDataToMemory(data: self.allEpisodes, in: DataBase.episodesArchiveURL)
            })
            
        }
    }
    
    private func getAllLocations() {
        if let savedLocations = loadLocationsFromMemory() {
            allLocations = savedLocations
        } else {
            allLocations = [Location]()
     /*       defer {
                allLocations.sort()
            } */
            networkManager?.fetchLocations(completion: { result in
                switch result {
                case .success(let locations):
                    self.allLocations.append(contentsOf: locations)
                case .failure(let error):
                    print(error)
                }
                self.saveDataToMemory(data: self.allLocations, in: DataBase.locationsArchiveURL)
            })
            
        }
    }
    
    func findCharactersWithAppropriateUrls(urls: [URL]) -> [TheCharacter] {
        var characters = self.allCharacters.filter { character in
            return urls.contains(character.url)
        }
        characters.sort()
        return characters
    }
}

