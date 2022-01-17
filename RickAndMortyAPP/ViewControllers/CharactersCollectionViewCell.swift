import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = UIImage(named: "spinner")
    }
}
