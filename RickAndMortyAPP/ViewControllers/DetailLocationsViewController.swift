//
//  DetailLocationsViewController.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 18.09.2021.
//

import UIKit

class DetailLocationViewController: UIViewController {
    
    var location: Location
    
    init?(coder: NSCoder, location: Location) {
        self.location = location
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var typeDetailLabel: UILabel!
    @IBOutlet weak var dimensionDetailLabel: UILabel!
    @IBOutlet weak var residentsDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        nameDetailLabel.text = location.name
        typeDetailLabel.text = location.type
        dimensionDetailLabel.text = location.dimension
        let stringResidents = location.residents.map {$0.absoluteString}
        residentsDetailLabel.text = stringResidents.first
        navigationItem.title = location.name
        
    }
}
