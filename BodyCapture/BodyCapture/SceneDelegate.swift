//
//  SceneDelegate.swift
//  BodyCapture
//
//  Created by junseok on 1/24/24.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    weak var viewController: UIViewController?
    var window: UIWindow?
    var currentUser: User?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        //kakao login
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
        
        //google login
        guard let url = URLContexts.first?.url else {return}
        let _ = GIDSignIn.sharedInstance.handle(url)
    }
    
    //어떤 화면? 함수
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        checkIfUserIsLoggedIn()
        window?.makeKeyAndVisible()
    }

    func checkIfUserIsLoggedIn() {
        isTokenValid { isValid in
            DispatchQueue.main.async {
                if isValid {
                    // 자동로그인시 유저 정보 백엔드에서 불러오는 로직 추가
                    // 토큰이 유효한 경우, MainTabController 표시
                    self.window?.rootViewController = MainTabController(user: self.currentUser!)
                } else {
                    // 토큰이 유효하지 않은 경우, LoginController를 표시
                    let loginController = LoginViewController()
                    let navController = UINavigationController(rootViewController: loginController)
                    navController.modalPresentationStyle = .fullScreen
                    self.window?.rootViewController = navController
                }
            }
        }
    }

    //구현해야할 것! : 토큰 유효성 검사 함수 :::: 백엔드에서 검증하면 Boolean 받아오는 걸로 다시 구현
    func isTokenValid(completion: @escaping (Bool) -> Void) {
        let socialIsWhat: String? = UserDefaults.standard.object(forKey: "socialIsWhat") as? String
        
        guard let socialIsWhat = socialIsWhat else {
            completion(false)
            return
        }
        
//        //userdefault 초기화
//         for key in UserDefaults.standard.dictionaryRepresentation().keys {
//                    UserDefaults.standard.removeObject(forKey: key.description)
//            }
        
        if socialIsWhat == "kakao" {
            //kakao 로그인 확인 구현
            if (AuthApi.hasToken()) {//유효한 토큰 존재
                UserApi.shared.accessTokenInfo { (_, error) in
                    if let error = error {
                        completion(false)
                    }
                    else {
                        //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                        // 로그인된 사용자의 정보를 가져옴
                        UserApi.shared.me() { (user, error) in
                            if let error = error {
                                print("사용자 정보 요청 실패: \(error)")
                            }
                            else if let user = user {
                                self.currentUser = User(
                                    identifier: String(user.id!),
                                    fullName: user.kakaoAccount?.profile?.nickname ?? "Unknown",
                                    email: user.kakaoAccount?.email,
                                    socialIsWhat: "kakao"
                                )
                                // user 객체를 활용하여 필요한 정보 사용
                                completion(true)
                            }
                        }
                    }
                }
            }
            else {
                //로그인 필요
            }
        } else if socialIsWhat == "google" {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if error != nil || user == nil {
                    //비로그인 상태
                    completion(false)
                } else {
                    //로그인 상태
                    self.currentUser = User(
                        identifier: (user?.userID!)!,
                        fullName: user?.profile!.name,
                        email: user?.profile?.email,
                        socialIsWhat: "google"
                    )
                    completion(true)
                }
            }
        } else if socialIsWhat == "apple" {
            //apple 로그인 확인 구현
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: (UserDefaults.standard.object(forKey: "AppleUserID") as? String)!) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // User is logged in
                    self.currentUser = User(
                        fullName: "이준석"
                    )
                    completion(true)
                case .revoked, .notFound:
                    // User is not logged in
                    completion(false)
                default:
                    // Unknown state
                    completion(false)
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

