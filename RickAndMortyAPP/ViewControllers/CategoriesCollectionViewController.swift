import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController, DataBaseAvailable {
    
    private let categories = ["Characters", "Locations", "Episodes"]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(20)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(view.bounds.height/3.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        configureCell(cell, forCategoryAt: indexPath)
    
        return cell
    }
    
    func configureCell(_ cell: CategoryCollectionViewCell, forCategoryAt indexPath: IndexPath) {
        cell.layer.cornerRadius = CGFloat(15)
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.imageView.image = UIImage(named: String(indexPath.item))
        cell.nameLabel.text = categories[indexPath.row]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            performSegue(withIdentifier: "characters", sender: nil)
        case [0, 1]:
            performSegue(withIdentifier: "locations", sender: nil)
        default:
            performSegue(withIdentifier: "episodes", sender: nil)
        }
    }

}
