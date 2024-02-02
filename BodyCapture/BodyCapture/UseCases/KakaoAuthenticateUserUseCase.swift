
import UIKit
import KakaoSDKUser
import KakaoSDKAuth

class KakaoAuthenticateUserUseCase {
    
    weak var viewController: UIViewController?
    
    func handleLoginSuccess(oauthToken: OAuthToken?) {
        UserApi.shared.me { [weak self] (user, error) in
            guard let self = self else { return }
            if let error = error {
                print(error)
            } else if let user = user, let oauthToken = oauthToken {
                let newUser = User(
                    identifier: String(user.id!),
                    fullName: user.kakaoAccount?.profile?.nickname,
                    email: user.kakaoAccount?.email,
                    socialIsWhat: "kakao"
                )
                
                print("kakao user info: \(newUser)")
                
                UserDefaults.standard.set("kakao", forKey: "socialIsWhat")
                self.navigateToNextScreen(with: newUser)
            }
        }
    }
    
    func navigateToNextScreen(with user: User) {
        // 다음 화면으로 이동하는 로직
        if sendUserDataToServer().isUserExist(with: user) {
            let nexttab = MainTabController()
            nexttab.currentUser = user
            nexttab.modalPresentationStyle = .fullScreen
            viewController?.present(nexttab, animated: true, completion: nil)
        } else {
            let nexttab = RegisterViewController()
            nexttab.currentUser = user
            nexttab.modalPresentationStyle = .fullScreen
            viewController?.present(nexttab, animated: true, completion: nil)
        }
    }
}
