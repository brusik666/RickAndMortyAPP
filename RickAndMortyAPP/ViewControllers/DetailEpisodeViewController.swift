import UIKit

class DetailEpisodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var episode: Episode
    let reuseIdentifier = "Cell"
    var images: [UIImage]!
    var characters = [TheCharacter]()
    
    init?(coder: NSCoder, episode: Episode) {
        self.episode = episode
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var airDateDetailLabel: UILabel!
    @IBOutlet weak var episodeDetailLabel: UILabel!
    @IBOutlet weak var charactersDetailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Vdl")
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        updateUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        print(episode.characters.count)

        
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10.0)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
      //  section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episode.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CharactersCollectionViewCell else { return UICollectionViewCell() }
        ApiRequestsController.shared.fetchSingleCharacter(url: episode.characters[indexPath.row]) { (result) in
        
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    cell.nameLabel.text = character.name
                    ApiRequestsController.shared.fetchCharactersImage(withURL: character.imageURL) { (image) in
                        guard let image = image else { return }
                        DispatchQueue.main.async {

                            cell.imageView.image = image
                            cell.setNeedsLayout()
                            self.characters.append(character)

                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    func updateUI() {
        nameDetailLabel.text = episode.name
        airDateDetailLabel.text = episode.airDate
        episodeDetailLabel.text = episode.episode
        title = episode.name
    }
    @IBSegueAction func showSingleCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let character = characters[indexPath.row]
        print(characters.count)

        return DetailCharacterViewController(coder: coder, character: character)
    }
}
