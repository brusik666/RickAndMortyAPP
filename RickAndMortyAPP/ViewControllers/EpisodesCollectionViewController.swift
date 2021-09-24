import UIKit

private let reuseIdentifier = "Cell"

class EpisodesCollectionViewController: UICollectionViewController {
    
    
    var episodes = [Episode]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        ApiRequestsController.shared.fetchEpisodes { (result) in
            switch result {
            case .success(let episodes):
                DispatchQueue.main.async {
                    self.episodes += episodes
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
 
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return episodes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpisodesCollectionViewCell
        cell.update(with: episodes[indexPath.row])
    
        return cell
    }

    @IBSegueAction func showEpisodeDetail(_ coder: NSCoder, sender: Any?) -> DetailEpisodeViewController? {
        guard let cell = sender as? EpisodesCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let episode = episodes[indexPath.row]
        return DetailEpisodeViewController(coder: coder, episode: episode)
    }
  

}
