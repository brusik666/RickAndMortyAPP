import UIKit

private let reuseIdentifier = "Cell"

class EpisodesCollectionViewController: UICollectionViewController, DataBaseAvailable {
    
    enum EpisodesSections: CaseIterable {
        case s1, s2, s3, s4
        
        var title: String {
            switch self {
            case .s1: return "Season 1"
            case .s2: return "Season 2"
            case .s3: return "Season 3"
            case .s4: return "Season 4"
            }
        }
    }
    
    let sections: [EpisodesSections] = EpisodesSections.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier)

    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(38))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        section.boundarySupplementaryItems = [headerItem]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
 
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier, for: indexPath) as! CollectionViewSectionHeader
        headerView.setTitle(title: section.title)
        headerView.setupView()
        return headerView
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let episodes = dataBase?.episodesBySeasons {
            return episodes[section].count
        } else {
            return 0
        }
    }
    
    
//  PROBLEM HERE
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpisodesCollectionViewCell
        cell.tag = indexPath.row
        cell.update(with: (dataBase?.episodesBySeasons[indexPath.section][indexPath.row])!, indexPath: indexPath)
        return cell
    }

    @IBSegueAction func showEpisodeDetail(_ coder: NSCoder, sender: Any?) -> DetailEpisodeViewController? {
        guard let cell = sender as? EpisodesCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let episode = (dataBase?.allEpisodes[indexPath.row])!
        return DetailEpisodeViewController(coder: coder, episode: episode)
    }
  

}
