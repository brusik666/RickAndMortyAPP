import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(forCategoryAt indexPath: IndexPath,_ categories: [String]) {
        self.layer.cornerRadius = CGFloat(15)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.imageView.image = UIImage(named: String(indexPath.item))
        self.nameLabel.text = categories[indexPath.row]
    }
}
