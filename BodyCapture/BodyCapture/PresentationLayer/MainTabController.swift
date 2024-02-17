import UIKit

class MainTabController: UITabBarController {
    //MARK: - properties
    
    var currentUser: User?
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: coder) 이것도 됨
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTab()
        view.backgroundColor = .white
    }
    
    func configureTab() {
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        let home = templateNavigationController(unselectedImage: UIImage(named: "home")!, selectedImage: UIImage(named: "home.fill")!, title: "홈", rootVC: HomeController(), user: currentUser!)
        let store =  templateNavigationController(unselectedImage: UIImage(named: "shop")!, selectedImage: UIImage(named: "shop.fill")!, title: "업체", rootVC: StoreController(), user: currentUser!)
        let heart = templateNavigationController(unselectedImage: UIImage(named: "heart")!, selectedImage: UIImage(named: "heart.fill")!, title: "찜", rootVC: HeartController(), user: currentUser!)
        let mypage = templateNavigationController(unselectedImage: UIImage(named: "mypage")!, selectedImage: UIImage(named: "mypage.fill")!, title: "마이페이지", rootVC: MyPlanController(), user: currentUser!)
        
        
        viewControllers = [home, store, heart, mypage]
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, title: String, rootVC: UIViewController, user: User) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.title = title
        
        if let homeController = rootVC as? HomeController {
            homeController.currentUser = user
        } else if let storeController = rootVC as? StoreController {
            storeController.currentUser = user
        } else if let heartController = rootVC as? HeartController {
            heartController.currentUser = user
        } else if let myPlanController = rootVC as? MyPlanController {
            myPlanController.currentUser = user
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        if #available(iOS 15, *) {
            nav.navigationBar.scrollEdgeAppearance = appearance
        }

        return nav
    }
    
}
