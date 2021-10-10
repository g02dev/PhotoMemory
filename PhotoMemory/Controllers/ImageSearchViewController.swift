// 

import UIKit

class ImageSearchViewController: UIViewController {
    
    // https://github.com/unsplash/unsplash-photopicker-ios

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addSelectedButton: UIButton!
    
    @IBAction func handleAdd(_ sender: Any) {
        delegate?.addImages(selectedImages)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Constants and Varibales
    
    var themeColor: UIColor!
    
    weak var delegate: AddImageDelegate?
    
    private var urls: [URL] = []
    
    private var selectedImages: [UIImage] = [] {
        didSet {
            addSelectedButton.setTitle("Add selected (\(selectedImages.count))", for: .normal)
            if canAdd {
                addSelectedButton.backgroundColor = themeColor
            } else {
                addSelectedButton.backgroundColor = .lightGray
            }
        }
    }
    
    private var canAdd: Bool {
        return selectedImages.count > 0
    }
    
    private var canSearch: Bool {
        return (searchBar.text ?? "").count > 0
    }
    
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        flowLayout.minimumLineSpacing = Constants.UI.imagesGridSpacing
        flowLayout.minimumInteritemSpacing = Constants.UI.imagesGridSpacing
        
        addSelectedButton.layer.cornerRadius = Constants.UI.buttonCornerRadius
        
        selectedImages = []
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setCollectionViewCellsSize()
    }
    
    
    // MARK: - Methods
    
    private func updateUI(isSearching: Bool) {
        activityIndicator.isHidden = !isSearching
        collectionView.isHidden = isSearching
    }
    
    private func setCollectionViewCellsSize() {
        let spacing = Constants.UI.imagesGridSpacing
        let columnsCount = Constants.UI.imagesColumnsCount
        let frame = collectionView.frame
        let itemSize = ScrolableGrid.squareItemSize(spacing: spacing, columnsCount: columnsCount, frame: frame)
        flowLayout.itemSize = itemSize
    }
    
    private func searchIfPossible() {
        guard canSearch else {
            showAlert(title: "", message: "Search query is empty. Type something to start searching.")
            return
        }
        
        selectedImages = []
        updateUI(isSearching: true)
        
        let query = searchBar.text!
        UnsplashClient().search(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newUrls):
                self.urls = newUrls
            case .failure(let error):
                let alertTitle = ""
                let alertMessage = error.localizedDescription
                self.showAlert(title: alertTitle, message: alertMessage)
            }
            
            self.updateUI(isSearching: false)
            self.collectionView.reloadData()
        }
    }

}


extension ImageSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = urls[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseId.searchImageCell, for: indexPath) as! SearchImageCollectionViewCell
        cell.url = url
        return cell
    }
}


extension ImageSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchImageCollectionViewCell
        
        if cell.isLoaded, let image = cell.imageView.image {
            if let index = selectedImages.firstIndex(of: image) {
                selectedImages.remove(at: index)
                cell.deselect()
            } else {
                selectedImages.append(image)
                cell.select(with: themeColor)
            }
        }
    }
}


extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchIfPossible()
    }
}
