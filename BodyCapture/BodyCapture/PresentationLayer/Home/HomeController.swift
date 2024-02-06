import UIKit

class HomeController: UIViewController {
    // naviBar 컴포넌트 설정
    let customView = UIView()
    let imageView = UIImageView(image: UIImage(named: "homeNaviLogo"))
    let button = UIButton(type: .custom)
    //프로필 components
    let containerView = UIView()
    let greetingLabel = UILabel()
    let welcomeLabel = UILabel()
    lazy var profileImageButton = UIButton()
    // dday components
    let containerDdayView = UIView()
    let ddayLabel = UILabel()
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
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBarUI()
        configureProfileView()
        configureDdayView()
        view.addSubview(text1)
        
        NSLayoutConstraint.activate([
            text1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            text1.topAnchor.constraint(equalTo: containerDdayView.bottomAnchor)
        ])
        
        configureStoreUI()
        view.addSubview(text2)
        
        NSLayoutConstraint.activate([
            text2.topAnchor.constraint(equalTo: containerStoreView.bottomAnchor),
            text2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        configureStatusUI()
    }

    
    
    //MARK: - Actions
    @objc func notificationButtonTapped() {
        
        
    }
    
    @objc func profileImageTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
}
