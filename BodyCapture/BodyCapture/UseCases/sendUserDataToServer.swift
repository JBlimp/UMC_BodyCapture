//
//  sendUserDataToServer.swift
//  BodyCapture
//
//  Created by junseok on 2/2/24.
//

import UIKit
import Alamofire

class sendUserDataToServer {
    //서버로 user의 userID와 socialIsWhat을 보내 유저가 존재하는지 판단
    func isUserExist(with user: User) -> Bool {
        return true
    }
    
    func returnUser(with user: User) -> User {
        //일단 임시로 user 그대로 반환, 나중에 백엔드에서 정보 받아와서 User 완성시켜서 넘겨야함
        var backenduser = User(identifier: user.identifier)
        backenduser.fullName = user.fullName
        return backenduser
    }
}
