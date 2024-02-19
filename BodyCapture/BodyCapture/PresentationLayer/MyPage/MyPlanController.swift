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
        view.layer.borderColor = UIColor(hex: "085CFF").cgColor
        view.layer.borderWidth = 1.5
        view.layer.shadowColor = UIColor(hex: "6E6E6E").cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
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
        text.font = UIFont.boldSystemFont(ofSize: 18)
        return text
    }()
    
    let profileEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = UIColor(hex: "676767")
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
    
    let profileDetailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("자세히 보러가기>", for: .normal)
        button.setTitleColor(UIColor(hex: "6E6E6E"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(profileDetailButtonTouchUpInside), for: .touchUpInside)
        return button
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
    
    let studioBox: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(hex: "6E6E6E").cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.borderColor = UIColor(hex: "E7E7E7").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        return view
    }()
    
    let studioImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let studioName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let studioInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "84A2DE")
        return label
    }()
    
    let studioMoney: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let studioDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "5484E1")
        return label
    }()
    
    let studioDetailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("자세히 보러가기>", for: .normal)
        button.setTitleColor(UIColor(hex: "6E6E6E"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(studioBoxTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let makeupBox: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(hex: "6E6E6E").cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.borderColor = UIColor(hex: "E7E7E7").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        return view
    }()
    
    let makeupImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let makeupName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let makeupInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "84A2DE")
        return label
    }()
    
    let makeupMoney: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let makeupDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "5484E1")
        return label
    }()
    
    let makeupDetailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("자세히 보러가기>", for: .normal)
        button.setTitleColor(UIColor(hex: "6E6E6E"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(makeupBoxTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let hairshopBox: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(hex: "6E6E6E").cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.borderColor = UIColor(hex: "E7E7E7").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        return view
    }()
    
    let hairshopImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let hairshopName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let hairshopInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "84A2DE")
        return label
    }()
    
    let hairshopMoney: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let hairshopDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: "5484E1")
        return label
    }()
    
    let hairshopDetailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("자세히 보러가기>", for: .normal)
        button.setTitleColor(UIColor(hex: "6E6E6E"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(hairshopBoxTouchUpInside), for: .touchUpInside)
        return button
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
        
        self.navigationItem.title = (self.currentUser?.fullName)! + "님의 바디프로필 일정"
        
        profileName.text = currentUser?.fullName
        profileHeight.text = "키 " + (currentUserGoal?.height)! + "cm"
        profileWeight.text = "몸무게 " + (currentUserGoal?.weight)! + "kg"
        profileBMI.text = "BMI " + (currentUserGoal?.bmi)!
        profileBFP.text = "체지방률 " + (currentUserGoal?.bfp)!
        view.backgroundColor = .white
    }
    
    func setupLayouts() {
        let safeArea = view.safeAreaLayoutGuide
        let views = [profileBox, profileImage, profileName, profileEditButton, profileHeight, profileWeight, profileBMI, profileBFP, profileDetailButton, goalweight, ddayview, ddaytext, dday, myReservationText, studioBox, studioImage, studioName, studioInfo, studioMoney, studioDate, makeupBox, makeupImage, makeupInfo, makeupName, makeupMoney, makeupDate, hairshopBox, hairshopInfo, hairshopImage, hairshopName, hairshopDate, hairshopMoney, studioDetailButton, makeupDetailButton, hairshopDetailButton]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
            profileBox.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
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
            
            profileDetailButton.rightAnchor.constraint(equalTo: profileBox.rightAnchor, constant: -19),
            profileDetailButton.bottomAnchor.constraint(equalTo: profileBox.bottomAnchor, constant: -15),
            profileDetailButton.heightAnchor.constraint(equalToConstant: 14),
            
            myReservationText.topAnchor.constraint(equalTo: profileBox.bottomAnchor, constant: 148),
            myReservationText.leftAnchor.constraint(equalTo: profileBox.leftAnchor),
            myReservationText.widthAnchor.constraint(equalToConstant: 200),
            myReservationText.heightAnchor.constraint(equalToConstant: 25),
            
            studioBox.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            studioBox.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            studioBox.topAnchor.constraint(equalTo: myReservationText.bottomAnchor, constant: 6),
            studioBox.heightAnchor.constraint(equalToConstant: 114),
            
            studioImage.topAnchor.constraint(equalTo: studioBox.topAnchor, constant: 15),
            studioImage.leftAnchor.constraint(equalTo: studioBox.leftAnchor, constant: 19),
            studioImage.widthAnchor.constraint(equalToConstant: 50),
            studioImage.heightAnchor.constraint(equalToConstant: 50),
            
            studioName.leftAnchor.constraint(equalTo: studioBox.leftAnchor, constant: 82),
            studioName.topAnchor.constraint(equalTo: studioBox.topAnchor, constant: 15),
            studioName.heightAnchor.constraint(equalToConstant: 20),
            
            studioInfo.leftAnchor.constraint(equalTo: studioName.leftAnchor),
            studioInfo.topAnchor.constraint(equalTo: studioName.bottomAnchor, constant: 1),
            studioInfo.heightAnchor.constraint(equalToConstant: 17),
            
            studioMoney.leftAnchor.constraint(equalTo: studioName.leftAnchor),
            studioMoney.topAnchor.constraint(equalTo: studioInfo.bottomAnchor, constant: 1),
            studioMoney.heightAnchor.constraint(equalToConstant: 26),
            
            studioDate.leftAnchor.constraint(equalTo: studioName.leftAnchor),
            studioDate.topAnchor.constraint(equalTo: studioMoney.bottomAnchor, constant: 1),
            studioDate.heightAnchor.constraint(equalToConstant: 17),
            
            studioDetailButton.rightAnchor.constraint(equalTo: studioBox.rightAnchor, constant: -20),
            studioDetailButton.bottomAnchor.constraint(equalTo: studioBox.bottomAnchor, constant: -9),
            studioDetailButton.heightAnchor.constraint(equalToConstant: 14),
            
            makeupBox.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            makeupBox.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            makeupBox.topAnchor.constraint(equalTo: studioBox.bottomAnchor, constant: 21),
            makeupBox.heightAnchor.constraint(equalToConstant: 114),
            
            makeupImage.topAnchor.constraint(equalTo: makeupBox.topAnchor, constant: 15),
            makeupImage.leftAnchor.constraint(equalTo: makeupBox.leftAnchor, constant: 19),
            makeupImage.widthAnchor.constraint(equalToConstant: 50),
            makeupImage.heightAnchor.constraint(equalToConstant: 50),
            
            makeupName.leftAnchor.constraint(equalTo: makeupBox.leftAnchor, constant: 82),
            makeupName.topAnchor.constraint(equalTo: makeupBox.topAnchor, constant: 15),
            makeupName.heightAnchor.constraint(equalToConstant: 20),
            
            makeupInfo.leftAnchor.constraint(equalTo: makeupName.leftAnchor),
            makeupInfo.topAnchor.constraint(equalTo: makeupName.bottomAnchor, constant: 1),
            makeupInfo.heightAnchor.constraint(equalToConstant: 17),
            
            makeupMoney.leftAnchor.constraint(equalTo: makeupName.leftAnchor),
            makeupMoney.topAnchor.constraint(equalTo: makeupInfo.bottomAnchor, constant: 1),
            makeupMoney.heightAnchor.constraint(equalToConstant: 26),
            
            makeupDate.leftAnchor.constraint(equalTo: makeupName.leftAnchor),
            makeupDate.topAnchor.constraint(equalTo: makeupMoney.bottomAnchor, constant: 1),
            makeupDate.heightAnchor.constraint(equalToConstant: 17),
            
            makeupDetailButton.rightAnchor.constraint(equalTo: makeupBox.rightAnchor, constant: -20),
            makeupDetailButton.bottomAnchor.constraint(equalTo: makeupBox.bottomAnchor, constant: -9),
            makeupDetailButton.heightAnchor.constraint(equalToConstant: 14),
            
            hairshopBox.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            hairshopBox.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            hairshopBox.topAnchor.constraint(equalTo: makeupBox.bottomAnchor, constant: 21),
            hairshopBox.heightAnchor.constraint(equalToConstant: 114),
            
            hairshopImage.topAnchor.constraint(equalTo: hairshopBox.topAnchor, constant: 15),
            hairshopImage.leftAnchor.constraint(equalTo: hairshopBox.leftAnchor, constant: 19),
            hairshopImage.widthAnchor.constraint(equalToConstant: 50),
            hairshopImage.heightAnchor.constraint(equalToConstant: 50),
            
            hairshopName.leftAnchor.constraint(equalTo: hairshopBox.leftAnchor, constant: 82),
            hairshopName.topAnchor.constraint(equalTo: hairshopBox.topAnchor, constant: 15),
            hairshopName.heightAnchor.constraint(equalToConstant: 20),
            
            hairshopInfo.leftAnchor.constraint(equalTo: hairshopName.leftAnchor),
            hairshopInfo.topAnchor.constraint(equalTo: hairshopName.bottomAnchor, constant: 1),
            hairshopInfo.heightAnchor.constraint(equalToConstant: 17),
            
            hairshopMoney.leftAnchor.constraint(equalTo: hairshopName.leftAnchor),
            hairshopMoney.topAnchor.constraint(equalTo: hairshopInfo.bottomAnchor, constant: 1),
            hairshopMoney.heightAnchor.constraint(equalToConstant: 26),
            
            hairshopDate.leftAnchor.constraint(equalTo: hairshopName.leftAnchor),
            hairshopDate.topAnchor.constraint(equalTo: hairshopMoney.bottomAnchor, constant: 1),
            hairshopDate.heightAnchor.constraint(equalToConstant: 17),
            
            hairshopDetailButton.rightAnchor.constraint(equalTo: hairshopBox.rightAnchor, constant: -20),
            hairshopDetailButton.bottomAnchor.constraint(equalTo: hairshopBox.bottomAnchor, constant: -9),
            hairshopDetailButton.heightAnchor.constraint(equalToConstant: 14)
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
        studioName.text = "김하하 촬영기사"
        studioInfo.text = "경력 5년 | 몸짱 스튜디오 팀장 >"
        studioMoney.text = "200,000원"
        studioDate.text = "예약 날짜: 2024.10.30"
        
        return usergoal
    }
    
    @objc func profileDetailButtonTouchUpInside() {
        
    }
    
    @objc func profileEditButtonTouchUpInside() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc func studioBoxTouchUpInside() {
        
    }
    
    @objc func makeupBoxTouchUpInside() {
        
    }
    
    @objc func hairshopBoxTouchUpInside() {
        
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
