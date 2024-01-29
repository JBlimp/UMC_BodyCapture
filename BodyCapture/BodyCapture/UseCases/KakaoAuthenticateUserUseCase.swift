
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
                    token: oauthToken.accessToken
                )
                self.sendTokenToBackend(token: oauthToken.accessToken)
                self.navigateToNextScreen(with: newUser)
            }
        }
    }
    
    func sendTokenToBackend(token: String) {
            // 백엔드 서버로 토큰을 전송하는 HTTP 요청 로직을 구현 (HTTP POST)
            
        }
    
    func navigateToNextScreen(with user: User) {
        // 다음 화면으로 이동하는 로직
        let maintab = MainTabController()
        maintab.currentUser = user
        maintab.modalPresentationStyle = .fullScreen
        viewController?.present(maintab, animated: true, completion: nil)
        
    }
}
