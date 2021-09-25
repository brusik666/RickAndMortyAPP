import UIKit

class FilterCharactersViewController: UIViewController {

    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var unknownStatusButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var genderlessButton: UIButton!
    @IBOutlet weak var unknownGenderButton: UIButton!
    
    var status: String = ""
    var gender: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func aliveButtonTapped(_ sender: UIButton) {
        status = "alive"
    }
    @IBAction func deadButtonTapped(_ sender: UIButton) {
        status = "dead"
    }
    @IBAction func unknownStatusButtonTapped(_ sender: UIButton) {
        status = "unknown"
    }
    @IBAction func femaleButtonTapped(_ sender: UIButton) {
        gender = "female"
    }
    @IBAction func maleButtonTapped(_ sender: UIButton) {
        gender = "male"
    }
    @IBAction func genderlessButtonTapped(_ sender: UIButton) {
        gender = "genderless"
    }
    @IBAction func unknownGenderButtonTapped(_ sender: UIButton) {
        gender = "unknown"
    }
    @IBAction func applyFiltersButtonTapped(_ sender: UIButton) {
        
    }
   
    @IBAction func resetStatusButtonTapped(_ sender: UIButton) {
        status = ""
    }
    @IBAction func resetGenderButtonTapped(_ sender: UIButton) {
        gender = ""
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
                    var snapshot = NSDiffableDataSourceSnapshot<Section, TheCharacter>()
                    snapshot.appendSections([Section.main])
                    snapshot.appendItems(characters)
                    charactersViewController.configureCollectiobViewDataSource(charactersViewController.collectionView)
                    charactersViewController.collectionViewDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
                case .failure(let error):
                    print(error)
                }
            }
        }
}
}
