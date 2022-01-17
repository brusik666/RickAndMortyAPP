//
//  EpisodesCollectionViewCell.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 20.09.2021.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .quaternarySystemFill
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.masksToBounds = true
    }
    
    func update(with episode: Episode, indexPath: IndexPath) {
        guard self.tag == indexPath.row else { return }
        nameLabel.text = episode.name
        episodeLabel.text = episode.episodeSerialName
    }
}
