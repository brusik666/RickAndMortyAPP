//
//  DataBase.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 15.12.2021.
//

import Foundation
import UIKit

class DataBase: NetworkManagerAvailable {
    
    private(set) var allCharacters: [TheCharacter]!
    private(set) var allEpisodes: [Episode]!
    private(set) var allLocations: [Location]!
    lazy var filteredCharacters: [TheCharacter] = self.allCharacters
    lazy var episodesBySeasons: [[Episode]] = {
        var season1 = [Episode]()
        var season2 = [Episode]()
        var season3 = [Episode]()
        var season4 = [Episode]()
        
        allEpisodes.forEach { episode in
            if episode.episodeSerialName.contains("S01") {
                season1.append(episode)
            } else if episode.episodeSerialName.contains("S02") {
                season2.append(episode)
            } else if episode.episodeSerialName.contains("S03") {
                season3.append(episode)
            } else if episode.episodeSerialName.contains("S04"){
                season4.append(episode)
            }
        }
        let allSeasons = [season1, season2, season3, season4]
        return allSeasons
    }()
  //  lazy var charactersImages: [String: UIImage]
    
 /*   init() {
        getAllcharacters()
        getAllLocations()
        getAllEpisodes()
        self.episodesBySeasons = {
            var season1 = [Episode]()
            var season2 = [Episode]()
            var season3 = [Episode]()
            var season4 = [Episode]()
            
            allEpisodes.forEach { episode in
                if episode.episodeSerialName.contains("S01") {
                    season1.append(episode)
                } else if episode.episodeSerialName.contains("S02") {
                    season2.append(episode)
                } else if episode.episodeSerialName.contains("S03") {
                    season3.append(episode)
                } else if episode.episodeSerialName.contains("S04"){
                    season4.append(episode)
                }
            }
            let allSeasons = [season1, season2, season3, season4]
            return allSeasons
        }()
    } */
    
    func loadAllData() {
        getAllcharacters()
        getAllEpisodes()
        getAllLocations()
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
      //  self.allCharacters.sort()
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
        networkManager?.fetchLocations(completion: { result in
            switch result {
            case .success(let locations):
                self.allLocations.append(contentsOf: locations)
            case .failure(let error):
                print(error)
            }
        })
    }
}
