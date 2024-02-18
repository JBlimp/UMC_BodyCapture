//
//  MyPlanController.swift
//  BodyCapture
//
//  Created by 하상준 on 2/9/24.
//

import UIKit

class MyPlanController: UIViewController {
    var currentUser: User?
    var currentUserGoal: UserGoalHeightWeight?
    
    let profileBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.layer.cornerRadius = 32
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    let profileName: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18)
        return text
    }()
    
    let profileEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "profilesetting"), for: .normal)
        button.addTarget(self, action: #selector(profileEditButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let profileHeight: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor(hex: "444444")
        return text
    }()
    
    let profileWeight: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor(hex: "444444")
        return text
    }()
    
    let profileBMI: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor(hex: "444444")
        return text
    }()
    
    let profileBFP: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor(hex: "444444")
        return text
    }()
    
    let goalweight: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor(hex: "444444")
        return text
    }()
    
    let ddayview: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let ddaytext: UILabel = {
        let text = UILabel()
        
        return text
    }()
    
    let dday: UILabel = {
        let text = UILabel()
        
        return text
    }()
    
    let myReservationText: UILabel = {
        let text = UILabel()
        text.text = "나의 바디프로필 예약 현황"
        text.font = UIFont.systemFont(ofSize: 16)
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureNaviBarUI()
        setupLayouts()
    }
    
    func configureNaviBarUI() {
        self.navigationItem.backBarButtonItem?.title = (currentUser?.fullName)! + "님의 바디프로필 일정"
    }
    
    func setupViews() {
        currentUserGoal = requestUserGoalHeightWeight()
        
        profileName.text = currentUser?.fullName
        profileHeight.text = "키 " + (currentUserGoal?.height)! + "cm"
        profileWeight.text = "몸무게 " + (currentUserGoal?.weight)! + "kg"
        profileBMI.text = "BMI " + (currentUserGoal?.bmi)!
        profileBFP.text = "체지방률 " + (currentUserGoal?.bfp)!
        view.backgroundColor = .white
    }
    
    func setupLayouts() {
        let safeArea = view.safeAreaLayoutGuide
        let views = [profileBox, profileImage, profileName, profileEditButton, profileHeight, profileWeight, profileBMI, profileBFP, goalweight, ddayview, ddaytext, dday, myReservationText]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
            profileBox.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 35),
            profileBox.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 19),
            profileBox.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            profileBox.heightAnchor.constraint(equalToConstant: 90),
            
            profileImage.topAnchor.constraint(equalTo: profileBox.topAnchor, constant: 13),
            profileImage.leftAnchor.constraint(equalTo: profileBox.leftAnchor, constant: 12),
            profileImage.widthAnchor.constraint(equalToConstant: 64),
            profileImage.heightAnchor.constraint(equalToConstant: 64),
            
            profileName.leftAnchor.constraint(equalTo: profileBox.leftAnchor, constant: 97),
            profileName.topAnchor.constraint(equalTo: profileBox.topAnchor, constant: 11),
            profileName.heightAnchor.constraint(equalToConstant: 26),
            profileName.widthAnchor.constraint(equalToConstant: 50),
            
            profileEditButton.widthAnchor.constraint(equalToConstant: 16),
            profileEditButton.heightAnchor.constraint(equalToConstant: 16),
            profileEditButton.topAnchor.constraint(equalTo: profileBox.topAnchor, constant: 18),
            profileEditButton.leftAnchor.constraint(equalTo: profileBox.leftAnchor, constant: 150),
            
            profileHeight.leftAnchor.constraint(equalTo: profileName.leftAnchor),
            profileHeight.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 1),
            profileHeight.heightAnchor.constraint(equalToConstant: 20),
            profileHeight.widthAnchor.constraint(equalToConstant: 60),
            
            profileWeight.leftAnchor.constraint(equalTo: profileHeight.rightAnchor, constant: 11),
            profileWeight.topAnchor.constraint(equalTo: profileHeight.topAnchor),
            profileWeight.heightAnchor.constraint(equalToConstant: 20),
            profileWeight.widthAnchor.constraint(equalToConstant: 100),
            
            profileBMI.leftAnchor.constraint(equalTo: profileHeight.leftAnchor),
            profileBMI.topAnchor.constraint(equalTo: profileHeight.bottomAnchor, constant: 4),
            profileBMI.heightAnchor.constraint(equalToConstant: 20),
            profileBMI.widthAnchor.constraint(equalToConstant: 60),
            
            profileBFP.leftAnchor.constraint(equalTo: profileWeight.leftAnchor),
            profileBFP.topAnchor.constraint(equalTo: profileBMI.topAnchor),
            profileBFP.heightAnchor.constraint(equalToConstant: 20),
            profileBFP.widthAnchor.constraint(equalToConstant: 82),
            
            myReservationText.topAnchor.constraint(equalTo: profileBox.bottomAnchor, constant: 148),
            myReservationText.leftAnchor.constraint(equalTo: profileBox.leftAnchor),
            myReservationText.widthAnchor.constraint(equalToConstant: 200),
            myReservationText.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    //서버에 키, 몸무게, 체지방률, 목표체중 등등 요청
    func requestUserGoalHeightWeight() -> UserGoalHeightWeight {
        var usergoal = UserGoalHeightWeight()
        usergoal.identifier = currentUser?.identifier
        
        //임시로 정보 입력해두겠음
        usergoal.height = "100"
        usergoal.weight = "100"
        usergoal.bfp = "100"
        usergoal.bmi = "100"
        usergoal.goalWeight = "100"
        usergoal.goalbfp = "100"
        
        return usergoal
    }
    
    @objc func profileEditButtonTouchUpInside() {
        
    }
}
//
// #if DEBUG
// import SwiftUI
//
// struct VCPreView: PreviewProvider {
//     static var previews: some View {
//         MyPlanController().toPreview()
//     }
// }
// #endif
