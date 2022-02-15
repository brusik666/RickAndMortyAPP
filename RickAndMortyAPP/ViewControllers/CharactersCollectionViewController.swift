import UIKit
import Network

class CharactersCollectionViewController: UICollectionViewController, UISearchResultsUpdating, DataBaseAvailable, NetworkManagerAvailable {
    // MARK: Variables
    private let searchController = UISearchController()
    
    var charactersSnapshot: NSDiffableDataSourceSnapshot<Section, TheCharacter> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TheCharacter>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(dataBase.filteredCharacters.sorted())
        return snapshot
    }
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, TheCharacter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureCollectiobViewDataSource(collectionView)
        collectionViewDataSource.apply(charactersSnapshot, animatingDifferences: true, completion: nil)
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
      /*  let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .myGreen
        
        navigationController?.navigationBar.standardAppearance = appearance */
    }

    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsSearchResultsController = true
        navigationItem.backBarButtonItem?.tintColor = .green
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func configureCollectiobViewDataSource(_ collectionView: UICollectionView) {
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, TheCharacter>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
            cell.tag = indexPath.row
            cell.configure(characterName: character.name, characterImageUrl: character.imageURL)
            return cell
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchingString = searchController.searchBar.text,
           searchingString.isEmpty == false {
            dataBase.filteredCharacters = dataBase.allCharacters.filter { (character) -> Bool in
                character.name.localizedCaseInsensitiveContains(searchingString)
            }
        } else {
            dataBase.filteredCharacters = dataBase.allCharacters
        }
        collectionViewDataSource.apply(charactersSnapshot, animatingDifferences: true)
    }

    @IBSegueAction func showCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell),
              let character = collectionViewDataSource.itemIdentifier(for: indexPath) else { return nil }
        return DetailCharacterViewController(coder: coder, character: character)
    }
    
    @IBAction func unwindToCharactersCollectionViewController(unwindSegue : UIStoryboardSegue) {
        
    }
}

