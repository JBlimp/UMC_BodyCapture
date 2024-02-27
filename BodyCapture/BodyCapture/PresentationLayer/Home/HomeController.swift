import UIKit

class HomeController: UIViewController {
    //홈 컨트롤러 생성될때 User 정보 넘겨줘야함
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var currentUser: User?
    // naviBar 컴포넌트 설정
    let customView = UIView()
    let imageView = UIImageView(image: UIImage(named: "homeNaviLogo"))
    let button = UIButton(type: .custom)
    //프로필 components
    let containerView = UIView()
    let greetingLabel = UILabel()
    let welcomeLabel = UILabel()
    lazy var profileImage = UIImageView()
    
    // dday components
    let containerDdayView = UIView()
    let ddayLabel = UILabel()
    let directionLabel = {
        let dl = UILabel()
        dl.text = "내 예약 자세히 보기"
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.font = UIFont.systemFont(ofSize: 14)
        return dl
    }()
    // "스토어 둘러보기" 텍스트
    let text1 = {
        let t = UILabel()
        t.text = "스토어 둘러보기"
        t.textAlignment = .left
        t.font = UIFont.systemFont(ofSize: 16)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    // 스토어 카테고리
    var selectedButtonTag: Int? {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
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
    // "나의 상태" 텍스트
    let text2 = {
        let t = UILabel()
        t.text = "나의 상태"
        t.textAlignment = .left
        t.font = UIFont.systemFont(ofSize: 16)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    // 나의 상태
    let containerStatusView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    //추가
    
//    init(user: User) {
//        self.currentUser = user
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        //super.init(coder: coder) 이것도 됨
//    }
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentUser)
        setupScrollView()
        configureNaviBarUI()
        configureProfileView()
        configureDdayView()
        contentView.addSubview(text1)
        
        NSLayoutConstraint.activate([
            text1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            text1.topAnchor.constraint(equalTo: containerDdayView.bottomAnchor)
        ])
        
        configureStoreUI()
        contentView.addSubview(text2)
        
        NSLayoutConstraint.activate([
            text2.topAnchor.constraint(equalTo: containerStoreView.bottomAnchor),
            text2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        configureStatusUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("containerStatusView frame after layout: \(containerStatusView.frame)")
    }

    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // 스크롤 뷰 제약조건 설정
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // ContentView 제약조건 설정
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    //MARK: - Actions
    @objc func notificationButtonTapped() {
        
        
    }
    
    @objc func profileTapped() {
        let editVC = EditProfileViewController()
        editVC.currentUser = self.currentUser
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc func statusTapped() {
        let statusDetail = InbodyDetailController()
        statusDetail.currentUser = self.currentUser
        navigationController?.pushViewController(statusDetail, animated: true)
    }
}
