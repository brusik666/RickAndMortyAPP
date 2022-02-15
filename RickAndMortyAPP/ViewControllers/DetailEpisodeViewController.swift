import UIKit
import SafariServices

class DetailEpisodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DataBaseAvailable, NetworkManagerAvailable {

    var episode: Episode
    var indexPathOfEpisode: IndexPath
    
    init?(coder: NSCoder, episode: Episode, indexPathOfEpisode: IndexPath) {
        self.episode = episode
        self.indexPathOfEpisode = indexPathOfEpisode
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
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        //section.interGroupSpacing = 0
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
        let index = indexPath.row
        
        let characters = dataBase.findCharactersWithAppropriateUrls(urls: episode.characters)
        let character = characters[index]
        
        cell.configure(characterName: character.name, characterImageUrl: character.imageURL)
        
        return cell
    }
    
    func updateUI() {
        
        nameDetailLabel.text = episode.name
        airDateDetailLabel.text = episode.airDate
        episodeDetailLabel.text = episode.episodeSerialName
        charactersDetailLabel.text = "\(episode.characters.count)"
        configureWatchEpisodeButtonLayer()
    }
    
    func configureWatchEpisodeButtonLayer() {
        watchEpisodeButton.layer.cornerRadius = 15
        watchEpisodeButton.layer.borderWidth = 1
        watchEpisodeButton.layer.borderColor = UIColor.myGreen.cgColor
        watchEpisodeButton.layer.backgroundColor = self.view.backgroundColor?.cgColor
    }
    
    @IBSegueAction func showSingleCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let character = dataBase.findCharactersWithAppropriateUrls(urls: episode.characters)[indexPath.row]

        return DetailCharacterViewController(coder: coder, character: character)
    }
    @IBAction func watchEpisodeButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: Episode.episodesURLStrings["season\(indexPathOfEpisode.section + 1)"]![indexPathOfEpisode.row]) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}

