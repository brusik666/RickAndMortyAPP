//
//  DataBase.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 15.12.2021.
//

import Foundation
import UIKit

class DataBase: NetworkManagerAvailable {
    
    var addingImgDataCount: Int = 0
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("charactersImages").appendingPathExtension("plist")
    
    private(set) var allCharacters: [TheCharacter]!
    private(set) var allEpisodes: [Episode]!
    private(set) var allLocations: [Location]!
    var allImages: [String: Data]? = [:]
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
    
    func loadAllData() {
        getAllcharacters()
        getAllEpisodes()
        getAllLocations()
    }
    
    func addImageData(withName name: String, imageData: Data) {
        allImages?[name] = imageData
        saveAllImagesDataToMemory()
    }
    
    private func saveAllImagesDataToMemory() {
        let propertyListEncoder = PropertyListEncoder()
        let codedImageData = try? propertyListEncoder.encode(allImages)
        try? codedImageData?.write(to: DataBase.archiveURL, options: .noFileProtection)
    }
    
    private func loadImages() -> Dictionary<String, Data>? {
        guard let codedImagesData = try? Data(contentsOf: DataBase.archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        let allImagesDict = try? propertyListDecoder.decode(Dictionary<String, Data>.self , from: codedImagesData)
        return allImagesDict
    }
    
    private func getAllcharacters() {
        allCharacters = [TheCharacter]()
        networkManager?.fetchCharacters(completion: { result in
            switch result {
            case .success(let characters):
                self.allCharacters.append(contentsOf: characters)
                
            case .failure(let error):
                print(error)
            }
        })
    }

    
    private func getAllEpisodes() {
        allEpisodes = [Episode]()
        networkManager?.fetchEpisodes(completion: { result in
            switch result {
            case .success(let episodes):
                self.allEpisodes.append(contentsOf: episodes)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func getAllLocations() {
        allLocations = [Location]()
        defer {
            allLocations.sort()
        }
        networkManager?.fetchLocations(completion: { result in
            switch result {
            case .success(let locations):
                self.allLocations.append(contentsOf: locations)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func findCharactersWithAppropriateUrls(urls: [URL]) -> [TheCharacter] {
        var characters = self.allCharacters.filter { character in
            return urls.contains(character.url)
        }
        characters.sort()
        return characters
    }
}

