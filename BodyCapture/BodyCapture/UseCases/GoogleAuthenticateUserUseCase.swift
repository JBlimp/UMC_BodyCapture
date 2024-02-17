//
//  GoogleAuthenticateUserUseCase.swift
//  BodyCapture
//
//  Created by junseok on 2/2/24.
//

import UIKit
import GoogleSignIn

class GoogleAuthenticateUserUseCase {
    
    weak var viewController: UIViewController?
    
    func handleLoginSuccess(with user: User) {
        UserDefaults.standard.set("google", forKey: "socialIsWhat")
        print(user)
        self.navigateToNextScreen(with: user)
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
}
