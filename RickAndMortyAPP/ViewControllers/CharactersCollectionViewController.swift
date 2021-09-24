import UIKit

private let reuseIdentifier = "Cell"

class CharactersCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    var characters = [TheCharacter]()
    let searchController = UISearchController()
    lazy var filteredCharacters: [TheCharacter] = self.characters
    var charactersSnapshot: NSDiffableDataSourceSnapshot<Section, TheCharacter> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TheCharacter>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(filteredCharacters)
        return snapshot
    }
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, TheCharacter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsSearchResultsController = true
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        navigationItem.backBarButtonItem?.tintColor = .green
        ApiRequestsController.shared.fetchCharacters { (result) in
            switch result {
            case .success(let chatacters):
                self.updateUI(with: chatacters)
                self.collectionViewDataSource.apply(self.charactersSnapshot, animatingDifferences: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI(with characters: [TheCharacter]) {
        DispatchQueue.main.async {
            self.characters += characters
            self.filteredCharacters += characters
       //     self.collectionView.reloadData()
        }

    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureCollectiobViewDataSource(_ collectionView: UICollectionView) {
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, TheCharacter>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
            self.confugireCell(cell, for: character)
            return cell
        })

    }
    
    func confugireCell(_ cell: CharactersCollectionViewCell, for character: TheCharacter) {
        cell.nameLabel.text = character.name
        ApiRequestsController.shared.fetchCharactersImage(withURL: character.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchingString = searchController.searchBar.text,
           searchingString.isEmpty == false {
            filteredCharacters = characters.filter { (character) -> Bool in
                character.name.localizedCaseInsensitiveContains(searchingString)
            }
        } else {
            filteredCharacters = characters
        }
        collectionViewDataSource.apply(charactersSnapshot, animatingDifferences: true)
    }

    @IBSegueAction func showCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let character = filteredCharacters[indexPath.row]
        return DetailCharacterViewController(coder: coder, character: character)
    }
}
