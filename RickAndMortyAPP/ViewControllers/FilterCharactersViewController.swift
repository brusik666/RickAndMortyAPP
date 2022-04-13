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
    
    private enum Gender: String {
        case male = "male"
        case female = "female"
        case genderless = "genderless"
    }
    
    private enum Status: String {
        case alive = "alive"
        case dead = "dead"
        case unknown = "unknown"
    }
    
    //MARK: Variables
    private var status: [Status] = []
    private var gender: [Gender] = []

    
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
        manageStatus(filterType: Status.alive)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func deadButtonTapped(_ sender: UIButton) {
        manageStatus(filterType: Status.dead)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func unknownStatusButtonTapped(_ sender: UIButton) {
        manageStatus(filterType: Status.unknown)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func femaleButtonTapped(_ sender: UIButton) {
        manageGender(filterType: Gender.female)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func maleButtonTapped(_ sender: UIButton) {
        manageGender(filterType: Gender.male)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func genderlessButtonTapped(_ sender: UIButton) {
        manageGender(filterType: Gender.genderless)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }

    
    @IBAction func unknownGenderButtonTapped(_ sender: UIButton) {
        manageGender(filterType: Gender.genderless)
        toggleButtonSelection(sender: sender)
        configureButtonAnimation(sender: sender)
        configureButtonsColor(sender: [sender])
    }
    
    @IBAction func applyFiltersButtonTapped(_ sender: UIButton) {
    }
   
    @IBAction func resetStatusButtonTapped(_ sender: UIButton) {
        status = []
        deselectAllStatusButtons()
        configureButtonsColor(sender: [aliveButton, deadButton, unknownStatusButton])
        configureButtonAnimation(sender: sender)
        
    }
    @IBAction func resetGenderButtonTapped(_ sender: UIButton) {
        gender = []
        deselectAllGenderButtons()
        configureButtonsColor(sender: [femaleButton, maleButton, genderlessButton, unknownGenderButton])
        configureButtonAnimation(sender: sender)
    }
    
    private func manageStatus(filterType: Status) {
        if let index = status.firstIndex(of: filterType) {
            status.remove(at: index)
        } else { status.append(filterType) }
    }
    
    private func manageGender(filterType: Gender) {
        if let index = gender.firstIndex(of: filterType) {
            gender.remove(at: index)
        } else { gender.append(filterType) }
    }
    
    private func configureButtonAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    private func toggleButtonSelection(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    private func deselectAllStatusButtons() {
        aliveButton.isSelected = false
        deadButton.isSelected = false
        unknownStatusButton.isSelected = false
    }
    
    private func deselectAllGenderButtons() {
        femaleButton.isSelected = false
        maleButton.isSelected = false
        genderlessButton.isSelected = false
        unknownGenderButton.isSelected = false
    }
    
    private func configureButtonsColor(sender: [UIButton]) {
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
              !status.isEmpty && !gender.isEmpty else { return }
        var characterz: [TheCharacter] = []
        for status in status {
            let charactersToAppend = dataBase.filteredCharacters.filter { $0.status.lowercased() == status.rawValue.lowercased() }
            characterz += charactersToAppend
        }
        
        var characterzzz: [TheCharacter] = []
        for gender in gender {
            let charactersToAppend = characterz.filter { $0.gender.lowercased() == gender.rawValue.lowercased() }
            characterzzz += charactersToAppend
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, TheCharacter>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(characterzzz)
        
        charactersViewController.collectionViewDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
}
