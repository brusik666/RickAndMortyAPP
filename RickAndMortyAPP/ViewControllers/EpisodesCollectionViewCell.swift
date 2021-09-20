//
//  EpisodesCollectionViewCell.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 20.09.2021.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
    
    func update(with episode: Episode) {
        nameLabel.text = episode.name
    }
}
