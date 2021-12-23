//
//  DataBase.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 15.12.2021.
//

import Foundation

class DataBase {
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let charactersArchiveURL = documentsDirectory.appendingPathComponent("characters").appendingPathExtension("plist")
    static let locationsArchiveURL = documentsDirectory.appendingPathComponent("locations").appendingPathComponent("plist")
    static let episodesAtchieveURL = documentsDirectory.appendingPathComponent("episodes").appendingPathExtension("plist")
    
    private var allCharacters: [TheCharacter]? {
        guard let characters = self.loadAllCharacters() else { return nil }
        return characters
    }
    private var allEpisodes: [Episode] = []
    private var allLocations: [Location] = []
    private let propertyListDecoder = PropertyListDecoder()
    
    private func loadAllCharacters() -> [TheCharacter]? {
        do {
            let charactersData = try Data(contentsOf: DataBase.charactersArchiveURL)
            let allCharacters = try propertyListDecoder.decode(Array<TheCharacter>.self, from: charactersData)
            return allCharacters
        } catch {
            return nil
        }
    }
    
    private func loadAllEpisodes() {
        do {
            let episodesData = try Data(contentsOf: DataBase.episodesAtchieveURL)
            allEpisodes = try propertyListDecoder.decode(Array<Episode>.self, from: episodesData)
        } catch {
            return
        }
    }
    
    private func loadAllLocations() {
        do {
            let locationsData = try Data(contentsOf: DataBase.locationsArchiveURL)
            allLocations = try propertyListDecoder.decode(Array<Location>.self, from: locationsData)
        } catch {
            return
        }
    }
    
    func saveElements<T: Codable>(elements: [T]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedElements: Data!
        switch elements {
        case _ where elements is [TheCharacter]:
            codedElements = try? propertyListEncoder.encode(elements)
            try? codedElements.write(to: DataBase.charactersArchiveURL)
        case _ where elements is [Episode]:
            codedElements = try? propertyListEncoder.encode(elements)
            try? codedElements.write(to: DataBase.episodesAtchieveURL)
        case _ where elements is [Location]:
            codedElements = try? propertyListEncoder.encode(elements)
            try? codedElements.write(to: DataBase.locationsArchiveURL)
        default:
            break
        }
    }
    
    func getAllCharacters() -> [TheCharacter]? {
        guard allCharacters != nil else { return nil}
        return allCharacters
    }
    
    func getAllEpisodes() -> [Episode] {
        return allEpisodes
    }
    
    func getAllLocations() -> [Location] {
        return allLocations
    }
    
    
}
