import UIKit
import Combine

class StoreController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    var currentUser: User?
    
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
    
    var selectedButtonTag: Int? {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - collectionView 구현하기
    // 콜렉션 뷰 설정에 사용될 상수 정의
    let itemsPerRow: CGFloat = 2
    let itemsPerColumn: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    let minimumInteritemSpacing: CGFloat = 20.0
    let minimumLineSpacing: CGFloat = 20.0
    // 백엔드에서 가져오기
    
    var companyInfos: [CompanyInfo] = []
    var companyInfoRepository: CompanyInfoRepository = AlamofireCompanyInfoRepository()
    
    lazy var storeCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // 아이템 간의 줄 간격을 0으로 설정
        layout.minimumInteritemSpacing = 0 // 아이템 간의 간격을 0으로 설정
        layout.sectionInset = .zero // 섹션 인셋을 0으로 설정
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CompanyInfoCell.self, forCellWithReuseIdentifier: CompanyInfoCell.identifier)
        collectionView.register(StoreCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StoreCollectionHeader.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true // 페이징 활성화
        collectionView.showsHorizontalScrollIndicator = false // 수평 스크롤 인디케이터 비활성화
        return collectionView
    }()
    
    lazy var pickerViewController: PickerViewController = {
        let viewController = PickerViewController()
        viewController.modalPresentationStyle = .pageSheet
        return viewController
    }()
    
    var selectedCity: String?
    var selectedDistricts: [String] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("StoreController viewDidLoad")
        configureNaviBarUI()
        configureStoreUI()
        configureStoreCollection()
        subscribeToPickerSelection()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UserDefaults에서 선택된 버튼의 태그를 읽어옴
        if let selectedTag = UserDefaults.standard.value(forKey: "SelectedButtonTag") as? Int {
            updateSelectedButton(to: selectedTag)
            loadCompanyInfos(forCategoryIndex: selectedTag)
        }
    }
    
    func updateSelectedButton(to tag: Int) {
        for case let button as CustomButtonView in buttonsStackView.arrangedSubviews {
            button.isSelected = (button.tag == tag)
        }
        
    }
    
    func loadCompanyInfos(forCategoryIndex index: Int) {
        companyInfoRepository.fetchCompanyInfos(categoryIndex: index) { [weak self] newCompanyInfos in
            
            DispatchQueue.main.async {
                guard let self = self else {return}
                
                self.companyInfos = newCompanyInfos
                self.storeCollection.reloadData()
                
                if newCompanyInfos.isEmpty {
                    print("No company info was fetched. Handling fallback scenario.")
                }
            }
        }
    }
    func configureNaviBarUI() {
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "업체"
    }
    
    func subscribeToPickerSelection() {
            pickerViewController.selectionPublisher
                .sink { [weak self] selectedCity, selectedDistricts in
                    self?.selectedCity = selectedCity
                    self?.selectedDistricts = selectedDistricts
                    
                    // 여기에서 필요한 UI 업데이트나 데이터 로딩 로직을 추가
                    print("선택된 도시: \(selectedCity), 선택된 지역: \(selectedDistricts)")
                    // 필터링된 CompanyInfo 데이터 로딩 및 콜렉션 뷰 업데이트
                    self?.loadFilteredCompanyInfos()
                }
                .store(in: &subscriptions)
    }
    
    
    func loadFilteredCompanyInfos() {
        guard let selectedCity = selectedCity, !selectedDistricts.isEmpty else {
                print("선택된 도시나 지역이 없습니다.")
                return
            }
        
        guard let cityInfo = pickerViewController.cityInfo.first(where: { $0.cityName == selectedCity }) else {
                print("선택된 도시에 해당하는 정보를 찾을 수 없습니다.")
                return
            }

        let filteredStores = cityInfo.districts
            .filter { selectedDistricts.contains($0.districtName) }
            .flatMap { $0.stores } // 모든 선택된 지역의 상점을 하나의 배열로 통합
        
        self.companyInfos = filteredStores
        
        DispatchQueue.main.async {
            self.storeCollection.reloadData()
        }
    }

}
