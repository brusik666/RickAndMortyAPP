//
//  ConfiguringCell.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 11.10.2021.
//

import Foundation
import UIKit

protocol ConfiguringCell: NetworkManagerAvailable {

    var imageView: UIImageView {get set}
    var nameLabel: UILabel {get set}
}

extension ConfiguringCell {
    func configure(with name: String, and url: URL) {
        nameLabel.text = name
        networkManager?.fetchCharactersImage(withURL: url, completion: { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                imageView.image = image
            }
        })
    }
}

