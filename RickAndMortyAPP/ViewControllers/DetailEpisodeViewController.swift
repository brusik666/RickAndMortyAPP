//
//  DetailEpisodeViewController.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 20.09.2021.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
    
    var episode: Episode
    
    init?(coder: NSCoder, episode: Episode) {
        self.episode = episode
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var airDateDetailLabel: UILabel!
    @IBOutlet weak var episodeDetailLabel: UILabel!
    @IBOutlet weak var charactersDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        nameDetailLabel.text = episode.name
        airDateDetailLabel.text = episode.airDate
        episodeDetailLabel.text = episode.episode
        let stringCharacters = episode.characters.map {$0.absoluteString}
        charactersDetailLabel.text = stringCharacters.first!
        title = episode.name
    }

}
