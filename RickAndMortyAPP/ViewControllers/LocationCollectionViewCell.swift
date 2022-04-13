import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        self.backgroundColor = .quaternarySystemFill
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.myGreen.cgColor
        self.layer.masksToBounds = true
    }
}
