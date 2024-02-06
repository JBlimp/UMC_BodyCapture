//
//  HomeController+Layout.swift
//  BodyCapture
//
//  Created by 하상준 on 2/6/24.
//

import UIKit

extension HomeController {
    //MARK: - navi
    func configureNaviBarUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(imageView)
        
        navigationItem.titleView = customView
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        customView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // 알림 버튼 설정
        let bellIcon = UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal)
        let notificationButton = UIBarButtonItem(image: bellIcon, style: .plain, target: self, action: #selector(notificationButtonTapped))
        navigationItem.rightBarButtonItem = notificationButton
        
    }
    //MARK: - profile
    func configureProfileView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = ThemeColor.blue1
        
        let userName = "최서윤" // 서버 통신해서 이름, 프로필 이미지가져오기
        let userImage = UIImage(systemName: "person")
        
        greetingLabel.text = "\(userName)님, 안녕하세요."
        greetingLabel.textAlignment = .left
        
        welcomeLabel.text = "Body Capture에 오신 것을 환영합니다!"
        welcomeLabel.textAlignment = .left
        
        profileImageButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        profileImageButton.setBackgroundImage(userImage, for: .normal) //서버와 통신
        profileImageButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
        
        containerView.addSubview(profileImageButton)
        containerView.addSubview(greetingLabel)
        containerView.addSubview(welcomeLabel)
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            // 프로필 이미지 버튼의 제약 조건
            profileImageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            profileImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            profileImageButton.widthAnchor.constraint(equalToConstant: 50),
            profileImageButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 첫 번째 레이블의 제약 조건
            greetingLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 20),
            greetingLabel.centerYAnchor.constraint(equalTo: profileImageButton.centerYAnchor, constant: -10),
            
            // 두 번째 레이블의 제약 조건
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 20),
            welcomeLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
        ])
    }
    //MARK: - dday
    func configureDdayView() {
        containerDdayView.translatesAutoresizingMaskIntoConstraints = false
        ddayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerDdayView.backgroundColor = ThemeColor.blue1
        
        var dday = "365" //서버 통신
        ddayLabel.text = "D-\(dday)"
        ddayLabel.textAlignment = .center
        ddayLabel.numberOfLines = 0
        
        
        let firstLineText = "바디프로필 촬영까지"
        let secondLineText = "D-\(dday)"
        let attributedString = NSMutableAttributedString(string: "\(firstLineText)\n\(secondLineText)")
        
        // 첫째 줄 스타일
        let firstLineRange = (attributedString.string as NSString).range(of: firstLineText)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .semibold), range: firstLineRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: firstLineRange)
        
        // 둘째 줄 스타일
        let secondLineRange = (attributedString.string as NSString).range(of: secondLineText)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 30, weight: .regular), range: secondLineRange)
        attributedString.addAttribute(.foregroundColor, value: ThemeColor.blue3, range: secondLineRange)
        
        ddayLabel.attributedText = attributedString
        
        
        containerDdayView.addSubview(ddayLabel)
        view.addSubview(containerDdayView)
        
        NSLayoutConstraint.activate([
            containerDdayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerDdayView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            containerDdayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerDdayView.heightAnchor.constraint(equalToConstant: 120),
            
            ddayLabel.centerYAnchor.constraint(equalTo: containerDdayView.centerYAnchor),
            ddayLabel.centerXAnchor.constraint(equalTo: containerDdayView.centerXAnchor)
        ])
    }
    //MARK: - 스토어 4개 카테고리
    func configureStoreUI() {
        let titles = ["Studio", "Makeup", "Hairshop", "Package"]
        let images = [UIImage(named: "camera"), UIImage(named: "makeup"), UIImage(named: "dryer"), UIImage(named: "package")]
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.alignment = .fill
        buttonsStackView.spacing = 25
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (title, image) in zip(titles, images) {
            let customButtonView = CustomButtonView(image: image, title: title)
            buttonsStackView.addArrangedSubview(customButtonView)
        }
        
        containerStoreView.addSubview(buttonsStackView)
        view.addSubview(containerStoreView)
        containerStoreView.backgroundColor = ThemeColor.blue1
        
        NSLayoutConstraint.activate([
            containerStoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerStoreView.topAnchor.constraint(equalTo: text1.bottomAnchor),
            containerStoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerStoreView.heightAnchor.constraint(equalToConstant: 120),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: containerStoreView.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: containerStoreView.centerYAnchor)
        ])
    }
    //MARK: - "나의 상태
    func configureStatusUI() {
        view.addSubview(containerStatusView)
        containerStatusView.backgroundColor = ThemeColor.blue1
        NSLayoutConstraint.activate([
            containerStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerStatusView.topAnchor.constraint(equalTo: text2.bottomAnchor),
            containerStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerStatusView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            ])
    }
    
    
    
}

