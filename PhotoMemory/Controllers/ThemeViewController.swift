// 

import UIKit
import CoreData

class ThemeViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var currentImagesCountLabel: UILabel!
    @IBOutlet weak var constraintImagesCountLabel: UILabel!
    
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var colorsFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var imagesFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func handleSave(_ sender: Any) {
        let alertTitle = Constants.Alert.incompleteThemeTitle
        if name.count == 0 {
            self.showAlert(title: alertTitle, message: "Add theme name.")
        } else if images.count < Constants.Game.minImagesCount {
            self.showAlert(title: alertTitle, message: "Add more images. Minimum: \(Constants.Game.minImagesCount)")
        } else if images.count > Constants.Game.maxImagesCount {
            showAlert(title: alertTitle, message: "Remove some images. Maximum: \(Constants.Game.maxImagesCount)")
        } else {
            let newUserTheme = saveCurrentThemeObject()
            Defaults.theme = newUserTheme.theme
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Constants and Variables
    
    var userTheme: UserTheme?
    
    private var name: String {
        return nameTextField.text ?? ""
    }
    
    private var selectedColor: UIColor! {
        didSet {
            saveButton.backgroundColor = selectedColor
            colorsCollectionView.reloadData()
        }
    }
    
    private var images: [UIImage] = []
    
    private var canAddNewImage: Bool {
        return images.count < Constants.Game.maxImagesCount
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        saveButton.layer.cornerRadius = Constants.UI.buttonCornerRadius
        
        nameTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        colorsCollectionView.dataSource = self
        colorsCollectionView.delegate = self
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
                
        colorsFlowLayout.minimumLineSpacing = Constants.UI.colorsGridSpacing
        colorsFlowLayout.minimumInteritemSpacing = Constants.UI.colorsGridSpacing
        colorsFlowLayout.itemSize = CGSize(width: 35, height: 35)
        colorsFlowLayout.scrollDirection = .horizontal
        
        imagesFlowLayout.minimumLineSpacing = Constants.UI.imagesGridSpacing
        imagesFlowLayout.minimumInteritemSpacing = Constants.UI.imagesGridSpacing
        imagesFlowLayout.itemSize = CGSize(width: 1, height: 1)
        imagesFlowLayout.scrollDirection = .vertical
        
        if selectedColor == nil {
            selectedColor = DefaultColors.colors.first!
        }
        
        if userTheme != nil {
            title = "Edit Theme"
        }
        
        constraintImagesCountLabel.text = "min: \(Constants.Game.minImagesCount)  max: \(Constants.Game.maxImagesCount)"
        
        updateUI(with: userTheme)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setImagesCollectionViewCellsSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateImagesUI()
    }
    
    
    // MARK: - Methods
    
    private func updateUI(with userTheme: UserTheme?) {
        if let theme = userTheme?.theme {
            nameTextField.text = theme.name
            selectedColor = theme.color
            images = theme.images
        }
    }
    
    private func updateImagesUI() {
        currentImagesCountLabel.text = "\(images.count) / \(Constants.Game.minImagesCount)"
        imagesCollectionView.reloadData()
    }
    
    private func setImagesCollectionViewCellsSize() {
        let spacing = Constants.UI.imagesGridSpacing
        let columnsCount = Constants.UI.imagesColumnsCount
        let frame = imagesCollectionView.frame
        let itemSize = ScrolableGrid.squareItemSize(spacing: spacing, columnsCount: columnsCount, frame: frame)
        imagesFlowLayout.itemSize = itemSize
    }
    
    private func saveCurrentThemeObject() -> UserTheme {
        let context = Defaults.dataController.viewContext
        
        // Delete old theme
        if let oldUserTheme = userTheme {
            context.delete(oldUserTheme)
        }
        
        // Create new theme
        let newUserTheme = UserTheme(context: context, name: name, color: selectedColor, images: images)
        
        try? Defaults.dataController.viewContext.saveIfNeeded()
        
        return newUserTheme
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.imageSearch {
            let vc = segue.destination as! ImageSearchViewController
            vc.delegate = self
            vc.themeColor = selectedColor
        }
    }
}


extension ThemeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case colorsCollectionView:
            return DefaultColors.colors.count
        case imagesCollectionView:
            if canAddNewImage {
                return images.count + 1
            } else {
                return images.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        
        case colorsCollectionView:
            let color = DefaultColors.colors[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseId.themeColorCell, for: indexPath) as! ThemeColorCollectionViewCell
            cell.color = color
            cell.isSelectedColor = color == selectedColor
            return cell
        case imagesCollectionView:
            if canAddNewImage && indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseId.themeNewImageCell, for: indexPath) as! ThemeNewImageCollectionViewCell
                return cell
            } else {
                let imageIndex = canAddNewImage ? indexPath.item - 1 : indexPath.item
                let image = images[imageIndex]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseId.themeImageCell, for: indexPath) as! ThemeImageCollectionViewCell
                cell.image = image
                return cell
            }
        default:
            fatalError("Unknown collection view")
        }
    }
}


extension ThemeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case colorsCollectionView:
            let color = DefaultColors.colors[indexPath.item]
            selectedColor = color
        case imagesCollectionView:
            if canAddNewImage && indexPath.item == 0 {
                performSegue(withIdentifier: Constants.Segue.imageSearch, sender: nil)
            } else {
                let imageIndex = canAddNewImage ? indexPath.item - 1 : indexPath.item
                images.remove(at: imageIndex)
                updateImagesUI()
            }
        default:
            return
        }
    }
}


extension ThemeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension ThemeViewController: AddImageDelegate {
    func addImages(_ images: [UIImage]) {
        self.images.append(contentsOf: images)
    }
}


protocol AddImageDelegate: AnyObject {
    func addImages(_ images: [UIImage])
}
