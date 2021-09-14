import UIKit

private let reuseIdentifier = "Cell"

class CharactersCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    var characters = [TheCharacter]()
    let searchController = UISearchController()
    lazy var filterdCharacters: [TheCharacter] = self.characters

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        navigationItem.backBarButtonItem?.tintColor = .green
        ApiRequestsController.shared.fetchCharacters { (result) in
            switch result {
            case .success(let chatacters):
                self.updateUI(with: chatacters)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI(with characters: [TheCharacter]) {
        DispatchQueue.main.async {
            self.characters += characters
            self.collectionView.reloadData()
        }

    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
       // print("generateLayout")
        return layout
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  print("numbersOfItemsInsSection")
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
        self.confugireCell(cell, forCharacterAt: indexPath)
     //   print("cellForRow")
        // Configure the cell
        return cell
    }
    
    func confugireCell(_ cell: CharactersCollectionViewCell, forCharacterAt indexPath: IndexPath) {
        let character = characters[indexPath.row]        
        cell.nameLabel.text = character.name
        ApiRequestsController.shared.fetchCharactersImage(withURL: character.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.collectionView.indexPath(for: cell),
                   currentIndexPath != indexPath {
                    return
                }
                cell.imageView.image = image
                cell.setNeedsLayout()
            }
        }
    //    print("configureCell")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    @IBSegueAction func showCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let character = characters[indexPath.row]
        return DetailCharacterViewController(coder: coder, character: character)
    }
}
