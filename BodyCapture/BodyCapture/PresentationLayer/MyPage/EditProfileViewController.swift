
import UIKit
import AuthenticationServices
import KakaoSDKUser
import GoogleSignIn

class EditProfileViewController: UIViewController {
    var currentUser: User?
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(logoutButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        let views = [logoutButton]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
        ])
    }
    
    @objc func logoutButtonTouchUpInside() {
        let socialIsWhat = currentUser?.socialIsWhat
        
        //현재 사용자 정보와 UserDefaults에 저장된 로그인 정보가 다를 경우 UserDefaults 초기화후 앱 강제종료
        if socialIsWhat == UserDefaults.standard.string(forKey: "socialIsWhat") {
            forceRestart()
        }
        
        if socialIsWhat == "kakao" {
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("logout() success.")
                    
                    // 최초 화면으로
                }
            }
        } else if socialIsWhat == "google" {
            GIDSignIn.sharedInstance.signOut()
            //최초 화면으로
        } else if socialIsWhat == "apple" {
            
        } else {
            forceRestart()
        }
    }
    
    func forceRestart() {
        let popup = UIAlertController(title: "오류가 발생했습니다", message: "앱을 종료합니다. 다시 로그인해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: alertHandler(_: ))
        popup.addAction(action)
        self.present(popup, animated: true)
    }
    
    func alertHandler(_ action: UIAlertAction) {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
        exit(0)
    }
}
