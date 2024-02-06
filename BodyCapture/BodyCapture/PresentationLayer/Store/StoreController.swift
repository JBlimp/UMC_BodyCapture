import UIKit

class StoreController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    // 스토어 카테고리
    let containerStoreView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    let studioButton = UIButton()
    let makeupButton = UIButton()
    let hairshopButton = UIButton()
    let packageButton = UIButton()
    let buttonsStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.spacing = 10
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBarUI()
        configureStoreUI()
    }
    
    func configureNaviBarUI() {
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "업체"
        searchController.searchBar.scopeButtonTitles = [
          "촬영", "메이크업", "헤어", "패키지"
        ]
    }
}
