// 1. 사용자 인증 로직 : 수집된 정보를 사용하여 사용자 인증
// 2. 백엔드 서버에 정보 전송 역할

import Foundation
import AuthenticationServices

class AppleAuthenticateUserUseCase {
    
    func execute(user: User) {
        // 사용자 인증 로직 + 데이터를 백엔드에 전송 로직
        print("사용자 인증 및 백엔드 서버 전송 로직 시작")
        print("User Identifier: \(user.identifier)")
        print("User fullname: \(String(describing: user.fullName))")
        print("User email: \(String(describing: user.email))")
        print("User token: \(String(describing: user.token))")
        authenticateUser(user: user) { [weak self] isAuthenticated in
            guard let self = self, isAuthenticated else {
                print("사용자 인증 실패")
                return
            }
            self.sendUserDataToBackend(user: user)
        }
    }

    func handleAuthorization(withAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            print("Apple ID 인증 정보 처리 시작")
            
            let userIdentifier = appleIDCredential.user
            let fullName = formatNameComponents(appleIDCredential.fullName)
            let email = appleIDCredential.email
            let identityToken = convertDataToString(appleIDCredential.identityToken)
            
            UserDefaults.standard.set(userIdentifier, forKey: "AppleUserID")
            
            let user = User(identifier: userIdentifier, fullName: fullName, email: email, token: identityToken)
            
            execute(user: user) //!!
        }
    }
    
    private func authenticateUser(user: User, completion: @escaping (Bool) -> Void) {

            completion(true) // 임시
        }

    private func sendUserDataToBackend(user: User) {
            // 백엔드 서버로 사용자 데이터를 전송하는 HTTP 요청 로직을 구현(HTTP POST 요청)
        print("백엔드 서버로 사용자 데이터 전송: \(user)")
    }

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
