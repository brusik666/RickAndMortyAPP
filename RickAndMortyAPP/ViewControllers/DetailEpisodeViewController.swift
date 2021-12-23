import UIKit
import SafariServices

class DetailEpisodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let reuseIdentifier = "Cell"
    
    var episode: Episode
    var characters = [TheCharacter]()
    
    init?(coder: NSCoder, episode: Episode) {
        self.episode = episode
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBOutlet weak var watchEpisodeButton: UIButton!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var airDateDetailLabel: UILabel!
    @IBOutlet weak var episodeDetailLabel: UILabel!
    @IBOutlet weak var charactersDetailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        updateUI()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10.0)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episode.characters.count
    }
    // FetchSingleCharacter move to VDL
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
        cell.tag = indexPath.row
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        ApiRequestsController.shared.fetchSingleCharacter(url: episode.characters[indexPath.row]) { (result) in
        
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    cell.nameLabel.text = character.name
                    self.characters.append(character)
                    ApiRequestsController.shared.fetchCharactersImage(withURL: character.imageURL) { (image) in
                        guard let image = image else { return }
                        DispatchQueue.main.async {
                            if cell.tag == indexPath.row {
                                cell.imageView.image = image
                                cell.setNeedsLayout()
                            }
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
        watchEpisodeButton.layer.cornerRadius = 15
        watchEpisodeButton.layer.borderWidth = 1
        watchEpisodeButton.layer.borderColor = UIColor.myGreen.cgColor
        watchEpisodeButton.layer.backgroundColor = self.view.backgroundColor?.cgColor
    }
    
    @IBSegueAction func showSingleCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let character = characters[indexPath.row]

        return DetailCharacterViewController(coder: coder, character: character)
    }
    @IBAction func watchEpisodeButtonTapped(_ sender: UIButton) {
        
        guard let url = URL(string: Episode.episodesURLStrings["season1"]![0]) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
        
    }
}

