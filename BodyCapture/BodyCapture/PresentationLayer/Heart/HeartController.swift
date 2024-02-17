

import UIKit

class HeartController: UIViewController {
    var currentUser: User?
    
    lazy var pageSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["스토어", "후기"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.layer.borderColor = UIColor.systemBlue.cgColor
        segmentControl.layer.borderWidth = 0.5
        segmentControl.layer.cornerRadius = 8
        segmentControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return segmentControl
    }()
    
    // store 콜렉션뷰 설정에 사용될 상수 정의
     let storeItemsPerLow: CGFloat = 2
     let storeItemsPerColumn: CGFloat = 2
     let storeSectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
     let storeMinimumInteritemSpacing: CGFloat = 20.0
     let storeMinimumLineSpacing: CGFloat = 20.0
    // 백엔드에서 가져오기
    var companyInfos: [CompanyInfo] = []
    var companyInfoRepository: CompanyInfoRepository = AlamofireCompanyInfoRepository()
    // 스토어 항목 선택시 보여질 컬렉션뷰
    lazy var storeView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 스크롤 방향 세로
        layout.minimumLineSpacing = 0 // 아이템 간의 줄 간격을 0으로 설정
        layout.minimumInteritemSpacing = 0 // 아이템 간의 간격을 0으로 설정
        layout.sectionInset = .zero // 섹션 인셋을 0으로 설정
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CompanyInfoCell.self, forCellWithReuseIdentifier: CompanyInfoCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true // 페이징 활성화
        collectionView.showsVerticalScrollIndicator = false // 수직 스크롤 인디케이터 비활성화
        return collectionView
    }()
    
    let reviewView = UIView()
    
    override func viewDidLoad() {
        configureNaviBarUI()
        setupViews()
        setupLayouts()
    }
    
    func configureNaviBarUI() {
        self.navigationItem.title = "찜 목록"
    }
    
    func setupViews() {
        loadCompanyInfos()
        reviewView.backgroundColor = .black
    }
    
    func setupLayouts() {
        let safeArea = view.safeAreaLayoutGuide
        let currentCollectionView = pageSegmentControl.selectedSegmentIndex == 0 ? storeView : reviewView
        view.backgroundColor = .white
        let views = [pageSegmentControl, currentCollectionView]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
            pageSegmentControl.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 21),
            pageSegmentControl.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            pageSegmentControl.heightAnchor.constraint(equalToConstant: 36),
            pageSegmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            
            currentCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            currentCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            currentCollectionView.topAnchor.constraint(equalTo: pageSegmentControl.bottomAnchor, constant: 54),
            currentCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func handleSegmentChange() {
        setupLayouts()
    }
    
    func loadCompanyInfos() {
        companyInfoRepository.fetchCompanyInfos(categoryIndex: 4) { [weak self] newCompanyInfos in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.companyInfos = newCompanyInfos
                self.storeView.reloadData()

                if newCompanyInfos.isEmpty {
                    print("No company info was fetched. Handling fallback scenario.")
                }
            }
        }
    }
}
//
//#if DEBUG
//import SwiftUI
//
//struct VCPreView: PreviewProvider {
//    static var previews: some View {
//        HeartController().toPreview()
//    }
//}
//#endif
