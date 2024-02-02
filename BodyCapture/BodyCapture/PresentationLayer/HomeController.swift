import UIKit

class HomeController: UIViewController {
    //MARK: - naviBar 컴포넌트 설정
    let customView = UIView()
    let imageView = UIImageView(image: UIImage(named: "homeNaviLogo"))
    let button = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBarUI()
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
    
    //MARK: - Actions
    @objc func notificationButtonTapped() {
        
    }
}
