// 1. 사용자 인증 로직 : 수집된 정보를 사용하여 사용자 인증
// 2. 백엔드 서버에 정보 전송 역할

import Foundation
import AuthenticationServices
import Alamofire

class AppleAuthenticateUserUseCase {
    
    weak var viewController: UIViewController?
    
    func handleAuthorization(withAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            print("Apple ID 인증 정보 처리 시작")
            
            let userIdentifier = appleIDCredential.user
            let fullName = formatNameComponents(appleIDCredential.fullName)
            let email = appleIDCredential.email
            //let identityToken = convertDataToString(appleIDCredential.identityToken)
                //jwt토큰
            
            UserDefaults.standard.set(userIdentifier, forKey: "AppleUserID")
            
            let user = User(identifier: userIdentifier, fullName: fullName, email: email)
            
            navigateToNextScreen(with: user)
            sendJWTToBE(with: user)
        }
    }
    
    func navigateToNextScreen(with user: User) {
        // 다음 화면으로 이동하는 로직
        if sendUserDataToServer().isUserExist(with: user) {
            let backendUser = sendUserDataToServer().returnUser(with: user)
            let nexttab = MainTabController(user: backendUser)
            nexttab.currentUser = backendUser
            nexttab.modalPresentationStyle = .fullScreen
            viewController?.present(nexttab, animated: true, completion: nil)
        } else {
            let nexttab = RegisterViewController()
            nexttab.currentUser = user
            nexttab.modalPresentationStyle = .fullScreen
            viewController?.present(nexttab, animated: true, completion: nil)
        }
    }
    
    func sendJWTToBE(with user: User) {
        // 서버 URL 설정
        let url = "???????"
        
        // User 정보를 딕셔너리로 구성
        let parameters: Parameters = [
            "userIdentifier": user.identifier,
            "fullName": user.fullName,
            "email": user.email,
        ]
        
        // Alamofire를 사용하여 HTTP POST 요청 전송
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response: \(value)")
                // 성공 처리 : 서버로부터 받은 응답을 파싱하여 필요한 작업 수행
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                // 에러 처리 로직
            }
        }

    }
    
//    private func authenticateUser(user: User, completion: @escaping (Bool) -> Void) {
//
//            completion(true) // 임시
//        }
    
}

extension AppleAuthenticateUserUseCase {
    // 타입 변환 메서드 (-> string)
    private func formatNameComponents(_ nameComponents: PersonNameComponents?) -> String? {
        guard let nameComponents = nameComponents else { return nil }
        return PersonNameComponentsFormatter.localizedString(from: nameComponents, style: .default)
    }

    private func convertDataToString(_ data: Data?) -> String? {
        guard let data = data else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
