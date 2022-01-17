//
//  ConfiguringCell.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 11.10.2021.
//

import Foundation
import UIKit

protocol ConfiguringCell {
    
    var imageView: UIImage? {get set}
    var nameLabel: UILabel {get set}
    
    func configure()
}

