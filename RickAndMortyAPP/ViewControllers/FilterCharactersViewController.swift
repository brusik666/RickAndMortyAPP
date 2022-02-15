import UIKit
import Network

class FilterCharactersViewController: UIViewController, DataBaseAvailable {
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
    
    enum Gender: String {
        case male = "male"
        case female = "female"
        case genderless = "genderless"
    }
    
    enum Status: String {
        case alive = "alive"
        case dead = "dead"
        case unknown = "unknown"
    }
 
    
    //MARK: Variables
    var status: String = ""
    var gender: String = ""

    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApplyButtonLayer()
    }
    //MARK: Functions
    
    private func configureApplyButtonLayer(){
        applyButton.layer.cornerRadius = 12
        applyButton.layer.borderWidth = 1
        applyButton.layer.borderColor = UIColor.myGreen.cgColor
    }
    
    @IBAction func aliveButtonTapped(_ sender: UIButton) {
        status = "alive"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func deadButtonTapped(_ sender: UIButton) {
        status = "dead"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func unknownStatusButtonTapped(_ sender: UIButton) {
        status = "unknown"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func femaleButtonTapped(_ sender: UIButton) {
        gender = "female"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func maleButtonTapped(_ sender: UIButton) {
        gender = "male"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func genderlessButtonTapped(_ sender: UIButton) {
        gender = "genderless"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func unknownGenderButtonTapped(_ sender: UIButton) {
        gender = "unknown"
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func applyFiltersButtonTapped(_ sender: UIButton) {
    }
   
    @IBAction func resetStatusButtonTapped(_ sender: UIButton) {
        status = ""
        deselectAllStatusButtons()
        configureButtonsColor(sender: [aliveButton, deadButton, unknownStatusButton])
        configureButtonAnimation(sender: sender)
        
    }
    @IBAction func resetGenderButtonTapped(_ sender: UIButton) {
        gender = ""
        deselectAllGenderButtons()
        configureButtonsColor(sender: [femaleButton, maleButton, genderlessButton, unknownGenderButton])
        configureButtonAnimation(sender: sender)
    }
    
    func configureButtonAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func toggleButtonSelection(sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    func deselectAllStatusButtons() {
        aliveButton.isSelected = false
        deadButton.isSelected = false
        unknownStatusButton.isSelected = false
    }
    
    func deselectAllGenderButtons() {
        femaleButton.isSelected = false
        maleButton.isSelected = false
        genderlessButton.isSelected = false
        unknownGenderButton.isSelected = false
    }
    
    func configureButtonsColor(sender: [UIButton]) {
        sender.forEach { button in
            switch button.isSelected {
            case true:
                button.tintColor = .myGreen
                button.setTitleColor(.myGreen, for: .selected)
            case false:
                button.tintColor = .white
                button.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let charactersViewController = segue.destination as? CharactersCollectionViewController,
              status != "" || gender != "" else { return }
        
        let characters = dataBase.allCharacters.filter { character in
            return character.gender.lowercased() == self.gender.lowercased() && character.status.lowercased() == self.status.lowercased()
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, TheCharacter>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(characters)
        
        charactersViewController.collectionViewDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
