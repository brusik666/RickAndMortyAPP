import UIKit

class DetailCharacterViewController: UIViewController, DataBaseAvailable {
    
    var character: TheCharacter

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var statusDetailLabel: UILabel!
    @IBOutlet weak var speciesDetailLabel: UILabel!
    @IBOutlet weak var genderDetailLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var lastLocationDetail: UILabel!
    
    init?(coder: NSCoder, character: TheCharacter) {
        self.character = character
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        imageView.layer.cornerRadius = 22
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        //title = character.name.uppercased()
        
        nameDetailLabel.text = character.name
        statusDetailLabel.text = character.status
        speciesDetailLabel.text = character.species
        genderDetailLabel.text = character.gender
        locationDetailLabel.text = character.originLocation["name"]
        lastLocationDetail.text = character.lastKnownLocation["name"]
        guard let characterImageData =  dataBase.allImages?[character.imageURL.absoluteString] else { return }
        let image = UIImage(data: characterImageData)
        imageView.image = image
    }

}
