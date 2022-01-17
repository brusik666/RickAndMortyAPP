import UIKit

private let reuseIdentifier = "Cell"

class LocationsCollectionViewController: UICollectionViewController, DataBaseAvailable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    }

    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute((100)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataBase?.allLocations.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocationCollectionViewCell
        cell.nameLabel.text = dataBase?.allLocations[indexPath.row].name
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true

        return cell
    }
    
    @IBSegueAction func showLocation(_ coder: NSCoder, sender: Any?) -> DetailLocationViewController? {
        guard let cell = sender as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell),
              let location = dataBase?.allLocations[indexPath.row] else { return nil }
        return DetailLocationViewController(coder: coder, location: location)
    }
}
