import UIKit

class FilterCharactersViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var unknownStatusButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var genderlessButton: UIButton!
    @IBOutlet weak var unknownGenderButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var resetStatusButton: UIButton!
    @IBOutlet weak var resetGenderButton: UIButton!
    
    var status: String = ""
    var gender: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyButton.layer.cornerRadius = 5.0
        aliveButton.setTitleColor(.myGreen, for: .selected)
        deadButton.setTitleColor(.myGreen, for: .selected)
        unknownStatusButton.setTitleColor(.myGreen, for: .selected)
        femaleButton.setTitleColor(.myGreen, for: .selected)
        maleButton.setTitleColor(.myGreen, for: .selected)
        genderlessButton.setTitleColor(.myGreen, for: .selected)
        unknownGenderButton.setTitleColor(.myGreen, for: .selected)
    }
    
    
    
    @IBAction func aliveButtonTapped(_ sender: UIButton) {
        status = "alive"
        aliveButton.isSelected = true
        deadButton.isSelected = false
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
        aliveButton.isSelected = false
        deadButton.isSelected = false
        unknownStatusButton.isSelected = false
        configureButtonAnimation(sender: sender)
    }
    @IBAction func resetGenderButtonTapped(_ sender: UIButton) {
        gender = ""
        maleButton.isSelected = false
        femaleButton.isSelected = false
        genderlessButton.isSelected = false
        unknownGenderButton.isSelected = false
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
            sender.tintColor = .myGreen
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
                 //   charactersViewController.characters += chracters
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
