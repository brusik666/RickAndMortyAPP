//
//  HeaderView.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 24.10.2021.
//

import Foundation
import UIKit

class CollectionViewSectionHeader: UICollectionReusableView {
    
    static let reuseIdentifier = "CollectionViewSectionHeader"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
        
    }()
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 15
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2)
        ])
    }
    
}
