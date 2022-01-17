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
        label.textColor = .systemOrange
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.128, green: 0.128, blue: 0.128, alpha: 1)
        label.layer.cornerRadius = 15.0
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.masksToBounds = true
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
        
        backgroundColor = UIColor(red: 0.128, green: 0.128, blue: 0.128, alpha: 1)
        layer.cornerRadius = 15
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
}
