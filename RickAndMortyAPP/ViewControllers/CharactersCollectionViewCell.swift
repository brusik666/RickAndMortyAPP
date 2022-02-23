import UIKit

class CharactersCollectionViewCell: UICollectionViewCell, NetworkManagerAvailable, DataBaseAvailable {
    
    static let reuseIdentifier = "Cell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var imageRequest: Cancellable?
    
    private var loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .medium
        activityIndicator.color = .myGreen
        
        activityIndicator.startAnimating()
        
        activityIndicator.autoresizingMask = [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
        
        return activityIndicator
    }()
    
    override func layoutSubviews() {
        
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.masksToBounds = true
        
        loadingActivityIndicator.center = CGPoint(x: imageView.bounds.midX, y: imageView.bounds.midY)
        loadingActivityIndicator.style = .large
        self.addSubview(loadingActivityIndicator)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        imageRequest?.cancel()
    }
    
    func configure(characterName: String, characterImageUrl: URL) {
        loadingActivityIndicator.startAnimating()
        nameLabel.text = characterName
        if let characterImageData = dataBase.allImages?[characterImageUrl.absoluteString] {
            //checking if imageData available in memory
            self.imageView.image = UIImage(data: characterImageData)
        } else {
            imageRequest = networkManager?.fetchCharactersImage(withURL: characterImageUrl, completion: { image in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
        }
        self.loadingActivityIndicator.stopAnimating()
    }
}
