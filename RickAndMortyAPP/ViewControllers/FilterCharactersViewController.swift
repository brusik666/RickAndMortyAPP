import UIKit

class FilterCharactersViewController: UIViewController {

    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var unknownStatusButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var genderlessButton: UIButton!
    @IBOutlet weak var unknownGenderButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    var status: String = ""
    var gender: String = ""
    let color = UIColor(red: 0.714, green: 0.886, blue: 0.055, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyButton.layer.cornerRadius = 5.0
        aliveButton.setTitleColor(color, for: .selected)
        deadButton.setTitleColor(color, for: .selected)
        unknownStatusButton.setTitleColor(color, for: .selected)
        femaleButton.setTitleColor(color, for: .selected)
        maleButton.setTitleColor(color, for: .selected)
        genderlessButton.setTitleColor(color, for: .selected)
        unknownGenderButton.setTitleColor(color, for: .selected)
        
    }
    
    
    
    @IBAction func aliveButtonTapped(_ sender: UIButton) {
        status = "alive"
        deadButton.isSelected = false
        aliveButton.isSelected = true
        unknownStatusButton.isSelected = false
        configureButtonAnimation(sender: sender)
    }
    @IBAction func deadButtonTapped(_ sender: UIButton) {
        status = "dead"
        aliveButton.isSelected = false
        deadButton.isSelected = true
        unknownStatusButton.isSelected = false
        configureButtonAnimation(sender: sender)
    }
    @IBAction func unknownStatusButtonTapped(_ sender: UIButton) {
        status = "unknown"
        aliveButton.isSelected = false
        deadButton.isSelected = false
        unknownStatusButton.isSelected = true
        configureButtonAnimation(sender: sender)
    }
    @IBAction func femaleButtonTapped(_ sender: UIButton) {
        gender = "female"
        femaleButton.isSelected = true
        maleButton.isSelected = false
        genderlessButton.isSelected = false
        unknownGenderButton.isSelected = false
        configureButtonAnimation(sender: sender)
    }
    @IBAction func maleButtonTapped(_ sender: UIButton) {
        gender = "male"
        femaleButton.isSelected = false
        maleButton.isSelected = true
        genderlessButton.isSelected = false
        unknownGenderButton.isSelected = false
        configureButtonAnimation(sender: sender)
    }
    @IBAction func genderlessButtonTapped(_ sender: UIButton) {
        gender = "genderless"
        femaleButton.isSelected = false
        maleButton.isSelected = false
        genderlessButton.isSelected = true
        unknownGenderButton.isSelected = false
        configureButtonAnimation(sender: sender)
        
    }
    @IBAction func unknownGenderButtonTapped(_ sender: UIButton) {
        gender = "unknown"
        femaleButton.isSelected = false
        maleButton.isSelected = false
        genderlessButton.isSelected = false
        unknownGenderButton.isSelected = true
        configureButtonAnimation(sender: sender)
    }
    @IBAction func applyFiltersButtonTapped(_ sender: UIButton) {

    }
   
    @IBAction func resetStatusButtonTapped(_ sender: UIButton) {
        status = ""
        configureButtonAnimation(sender: sender)
    }
    @IBAction func resetGenderButtonTapped(_ sender: UIButton) {
        gender = ""
        configureButtonAnimation(sender: sender)
    }
    
    func configureButtonAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func configureButtonTintColor(sender: UIButton) {
        switch sender.isSelected {
        case true:
            sender.tintColor = color
        case false:
            sender.tintColor = .white
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let charactersViewController = segue.destination as? CharactersCollectionViewController,
              status != "" || gender != "" else { return }
        ApiRequestsController.shared.fetchCharacters { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let chracters):
                    charactersViewController.characters += chracters
                    let characters = charactersViewController.characters.filter { character in
                        return character.gender.lowercased() == self.gender.lowercased() && character.status.lowercased() == self.status.lowercased()
                    }
                    charactersViewController.characters = characters
                    var snapshot = NSDiffableDataSourceSnapshot<Section, TheCharacter>()
                    snapshot.appendSections([Section.main])
                    snapshot.appendItems(characters)
                    
                    charactersViewController.collectionViewDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
                case .failure(let error):
                    print(error)
                }
            }
        }
        charactersViewController.configureCollectiobViewDataSource(charactersViewController.collectionView)
    }
    
}
