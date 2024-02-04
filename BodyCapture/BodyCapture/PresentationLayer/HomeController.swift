import UIKit

class HomeController: UIViewController {
    //MARK: - naviBar 컴포넌트 설정
    let customView = UIView()
    let imageView = UIImageView(image: UIImage(named: "homeNaviLogo"))
    let button = UIButton(type: .custom)
    //MARK: - 프로필 components
    
    let containerView = UIView()
    let greetingLabel = UILabel()
    let welcomeLabel = UILabel()
    lazy var profileImageButton = UIButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBarUI()
        configureProfileView()
    }
    
    func configureNaviBarUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(imageView)
        
        navigationItem.titleView = customView
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        customView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // 알림 버튼 설정
        let bellIcon = UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal)
        let notificationButton = UIBarButtonItem(image: bellIcon, style: .plain, target: self, action: #selector(notificationButtonTapped))
        navigationItem.rightBarButtonItem = notificationButton

    }
    
    func configureProfileView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = ThemeColor.blue1
        
        let userName = "최서윤" // 서버 통신해서 이름, 프로필 이미지가져오기
        let userImage = UIImage(systemName: "person")
        
        greetingLabel.text = "\(userName)님, 안녕하세요."
        greetingLabel.textAlignment = .left
        
        welcomeLabel.text = "Body Capture에 오신 것을 환영합니다!"
        welcomeLabel.textAlignment = .left
        
        profileImageButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        profileImageButton.setBackgroundImage(userImage, for: .normal) //서버와 통신
        profileImageButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
        
        containerView.addSubview(profileImageButton)
        containerView.addSubview(greetingLabel)
        containerView.addSubview(welcomeLabel)
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
          containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
          containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
          containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

          containerView.heightAnchor.constraint(equalToConstant: 120),
          
          // 프로필 이미지 버튼의 제약 조건
          profileImageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
          profileImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
          profileImageButton.widthAnchor.constraint(equalToConstant: 50),
          profileImageButton.heightAnchor.constraint(equalToConstant: 50),

          // 첫 번째 레이블의 제약 조건
          greetingLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 20),
          greetingLabel.centerYAnchor.constraint(equalTo: profileImageButton.centerYAnchor, constant: -10),
          
          // 두 번째 레이블의 제약 조건
          welcomeLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 20),
          welcomeLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
        ])
    }
    //MARK: - Actions
    @objc func notificationButtonTapped() {
        
    }
    
    @objc func profileImageTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
}
