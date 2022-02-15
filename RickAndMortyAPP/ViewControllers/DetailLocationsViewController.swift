import UIKit

class DetailLocationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DataBaseAvailable, NetworkManagerAvailable {
    
    var location: Location
    
    init?(coder: NSCoder, location: Location) {
        self.location = location
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var typeDetailLabel: UILabel!
    @IBOutlet weak var dimensionDetailLabel: UILabel!
    @IBOutlet weak var residentsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        updateUI()
        
    }
    
    func updateUI() {
        nameDetailLabel.text = location.name
        typeDetailLabel.text = location.type
        dimensionDetailLabel.text = location.dimension
        if location.residents.count > 0 {
            residentsLabel.isHidden = false
        } else {
            residentsLabel.isHidden = true
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10.0)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: spacing, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return location.residents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
        let characters = dataBase.findCharactersWithAppropriateUrls(urls: location.residents)
        let character = characters[indexPath.row]
        cell.configure(characterName: character.name, characterImageUrl: character.imageURL)
        return cell
    }
    @IBSegueAction func showSingleCharacter(_ coder: NSCoder, sender: Any?) -> DetailCharacterViewController? {
        guard let cell = sender as? CharactersCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return nil }
        let character = dataBase.findCharactersWithAppropriateUrls(urls: location.residents)[indexPath.row]
        
        return DetailCharacterViewController(coder: coder, character: character)
    }
}
