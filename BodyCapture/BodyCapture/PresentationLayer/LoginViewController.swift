import UIKit
import AuthenticationServices
import KakaoSDKUser
import GoogleSignIn


class LoginViewController: UIViewController {

    //var imageName = ""
    
    let logoImageView = {
        let logo = UIImageView()
        logo.backgroundColor = ThemeColor.blue2
        //logo.image = UIImage(named: <#T##String#>) 디자인 완료 후
        return logo
    }()
    
    let appleLoginButton = ASAuthorizationAppleIDButton()
    
    let kakaoLoginButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_large_wide"), for: .normal)
        button.backgroundColor = UIColor(hex: "#FEE500")
        button.layer.cornerRadius = 12
        return button
    }()
    
    let googleLoginButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ios_light_sq_SI"), for: .normal)
        button.backgroundColor = UIColor(hex: "#FEE500")
        button.layer.cornerRadius = 12
        //button.addTarget(self, action: #selector(kakaoLoginButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
    }
    //MARK: - AutoLayout + 추가적 ui설정
    func configureUI() {
        view.backgroundColor = .white
        appleLoginButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTouchUpInside), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(googleLoginButtonTouchUpInside), for: .touchUpInside)
        view.addSubview(logoImageView)
        view.addSubview(appleLoginButton)
        view.addSubview(kakaoLoginButton)
        view.addSubview(googleLoginButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 0.6)
        ])
        
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            googleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleLoginButton.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -20),
            googleLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: -20),
            appleLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        kakaoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            kakaoLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            kakaoLoginButton.widthAnchor.constraint(equalTo: appleLoginButton.widthAnchor),
            kakaoLoginButton.heightAnchor.constraint(equalTo: appleLoginButton.heightAnchor)
        ])
    }
    
    //MARK: - Helpers
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    //google login
    @objc func googleLoginButtonTouchUpInside(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { GIDSignInResult, error in
            guard error == nil else {
                //로그인 실패시
                let popup = UIAlertController(title: "로그인 실패", message: "다시 로그인해주세요", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style:  .default)
                popup.addAction(action)
                self.present(popup, animated: true)
                return
            }
            //로그인 성공시
            guard let user = GIDSignInResult?.user else {return}
            guard let profile = user.profile else {return}
            //유저 데이터 처리
            print(profile.email)
        }
        
    }
    
    //google 로그인 여부 확인 함수
    func checkGoogleLoginState() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                //비로그인 상태
                print("not sign in")
            } else {
                //로그인 상태
                guard let user = user else {return}
                guard let profile = user.profile else {return}
                //유저 데이터 처리
            }
        }
    }
    
    //kakao login
    @objc func kakaoLoginButtonTouchUpInside(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오톡으로 로그인 성공")
                    
                    _ = oauthToken
                    /// 로그인 관련 메소드 추가
                }
            }
        } else {
            
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    
                    _ = oauthToken
                    // 관련 메소드 추가
                    
                    UserApi.shared.me { user, error in
                        if let error = error {
                            print(error)
                        } else {
                            let profileImageURL = user?.kakaoAccount?.profile?.profileImageUrl
                            let nickname = user?.kakaoAccount?.profile?.nickname
                        }
                    }
                }
            }
        }
    }
    

}

//apple로 로그인 버튼 눌렀을 때의 처리
extension LoginViewController: ASAuthorizationControllerDelegate {
    // 인증 성공 처리
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        print("Apple 로그인 인증 성공")
        let authenticateUserUseCase = AppleAuthenticateUserUseCase()
        authenticateUserUseCase.handleAuthorization(withAuthorization: authorization)
        }
    
    // 인증 실패 처리
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple 로그인 인증 실패: \(error.localizedDescription)")
    }
}
