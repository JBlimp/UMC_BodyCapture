import UIKit

class MainTabController: UITabBarController {
    //MARK: - properties
    
    var currentUser: User?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTab()
        view.backgroundColor = .red
    }
    
    func configureTab() {
        view.backgroundColor = .blue
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        let home = templateNavigationController(unselectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootVC: HomeController())
        let store =  templateNavigationController(unselectedImage: UIImage(systemName: "storefront")!, selectedImage: UIImage(systemName: "storefront.fill")!, rootVC: StoreController())
        let heart = templateNavigationController(unselectedImage: UIImage(systemName: "heart")!, selectedImage: UIImage(systemName: "heart.fill")!, rootVC: HeartController())
        
        viewControllers = [home, store, heart]
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootVC: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        if #available(iOS 15, *) {
            nav.navigationBar.scrollEdgeAppearance = appearance
        }

        return nav
    }
    
}
