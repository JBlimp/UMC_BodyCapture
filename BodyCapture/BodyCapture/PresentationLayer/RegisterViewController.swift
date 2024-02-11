//
//  RegisterViewController.swift
//  BodyCapture
//
//  Created by junseok on 1/31/24.
//

import UIKit


class RegisterViewController : UIViewController {
    var currentUser: User?
    
    let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.backgroundColor = .clear
        logoImage.image = UIImage(named: "login.logo")
        return logoImage
    }()
    
    let nameField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)])
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    let genderSegmentControl: UISegmentedControl = {
        let genderSegmentControl = UISegmentedControl(items: ["남성", "여성"])
        genderSegmentControl.selectedSegmentIndex = 0
        genderSegmentControl.layer.borderColor = UIColor.systemBlue.cgColor
        genderSegmentControl.layer.borderWidth = 0.5
        genderSegmentControl.layer.cornerRadius = 8
        return genderSegmentControl
    }()
    
    let nicknameField: UITextField = {
        let nicknameField = UITextField()
        nicknameField.borderStyle = .roundedRect
        nicknameField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)])
        nicknameField.layer.borderColor = UIColor.systemBlue.cgColor
        nicknameField.layer.borderWidth = 0.5
        nicknameField.layer.cornerRadius = 8
        return nicknameField
    }()
    
    let checkNicknameButton: UIButton = {
        let checkNicknameButton = UIButton()
        checkNicknameButton.backgroundColor = UIColor(red: 0.31, green: 0.58, blue: 0.98, alpha: 1.00)
        checkNicknameButton.setTitle("중복확인", for: .normal)
        checkNicknameButton.layer.cornerRadius = 8
        checkNicknameButton.clipsToBounds = true
        checkNicknameButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        checkNicknameButton.addTarget(self, action: #selector(checkNicknameButtonTapped(_:)), for: .touchUpInside)
        return checkNicknameButton
    }()
    
    let birthdayField: UIButton = {
        let birthdayField = UIButton()
        birthdayField.layer.cornerRadius = 8
        birthdayField.layer.borderColor = UIColor.systemBlue.cgColor
        birthdayField.layer.borderWidth = 0.5
        birthdayField.setTitle(" 생년월일", for: .normal)
        birthdayField.setTitleColor(UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00), for: .normal)
        birthdayField.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        birthdayField.contentHorizontalAlignment = .left
        birthdayField.addTarget(self, action: #selector(birthdayFieldTouchUp), for: .touchUpInside)
        return birthdayField
    }()
    
    let emailField: UITextField = {
        let emailField = UITextField()
        emailField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)])
        emailField.borderStyle = .roundedRect
        emailField.isUserInteractionEnabled = false
        emailField.layer.borderColor = UIColor.systemBlue.cgColor
        emailField.layer.borderWidth = 0.5
        emailField.layer.cornerRadius = 8
        return emailField
    }()
    
    let agreeTitle: UITextView = {
        let agreeTitle = UITextView()
        agreeTitle.text = "서비스 정책"
        agreeTitle.font = UIFont.systemFont(ofSize: 14)
        agreeTitle.backgroundColor = .clear
        agreeTitle.textColor = .black
        agreeTitle.isEditable = false
        return agreeTitle
    }()
    
    let agreeBox: UIView = {
        let agreeBox = UIView()
        agreeBox.backgroundColor = UIColor(red: 0.88, green: 0.93, blue: 1.00, alpha: 1.00)
        agreeBox.clipsToBounds = true
        agreeBox.layer.cornerRadius = 8
        return agreeBox
    }()
    
    let agreeBoxLine: UIView = {
        let agreeBoxLine = UIView()
        agreeBoxLine.backgroundColor = UIColor(red: 0.59, green: 0.61, blue: 0.63, alpha: 1.00)
        return agreeBoxLine
    }()
    
    let allAgreeSwitch = CheckBox()
    let overFourteenSwitch = CheckBox()
    let termsOfServiceSwitch = CheckBox()
    let privacyPolicySwitch = CheckBox()
    let marketingSwitch = CheckBox()
    let detailButton1: UIButton = {
        let detailButton = UIButton()
        detailButton.backgroundColor = .clear
        detailButton.setTitle("자세히보기", for: .normal)
        detailButton.setTitleColor(UIColor.systemGray, for: .normal)
        detailButton.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        detailButton.addTarget(self, action: #selector(detailButton1Tapped), for: .touchUpInside)
        return detailButton
    }()
    
    let detailButton2: UIButton = {
        let detailButton = UIButton()
        detailButton.backgroundColor = .clear
        detailButton.setTitle("자세히보기", for: .normal)
        detailButton.setTitleColor(UIColor.systemGray, for: .normal)
        detailButton.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        detailButton.addTarget(self, action: #selector(detailButton2Tapped), for: .touchUpInside)
        return detailButton
    }()
    
    let signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.backgroundColor = UIColor(red: 0.31, green: 0.58, blue: 0.98, alpha: 1.00)
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signUpButton.layer.cornerRadius = 8
        signUpButton.clipsToBounds = true
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signUpButton.isEnabled = false
        return signUpButton
    }()
    
    let allAgreeText: UITextView = {
        let text = UITextView()
        text.text = "전체동의"
        text.font = UIFont.systemFont(ofSize: 11)
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        return text
    }()
    
    let overFourteenText: UITextView = {
        let text = UITextView()
        text.text = "만 14세 이상입니다(필수)"
        text.font = UIFont.systemFont(ofSize: 11)
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        return text
    }()
    
    let termsofServiceText: UITextView = {
        let text = UITextView()
        text.text = "서비스 이용약관 동의(필수)"
        text.font = UIFont.systemFont(ofSize: 11)
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        return text
    }()
    
    let privacyPolicyText: UITextView = {
        let text = UITextView()
        text.text = "개인정보 수집 및 이용 동의(필수)"
        text.font = UIFont.systemFont(ofSize: 11)
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        return text
    }()
    
    let marketingText: UITextView = {
        let text = UITextView()
        text.text = "마케팅 수신 동의(선택)"
        text.font = UIFont.systemFont(ofSize: 11)
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        
    }
    
    func setupViews() {
        //text field setting
        self.nameField.text = currentUser?.fullName
        self.emailField.text = currentUser?.email
        
        //약관동의 설정
        allAgreeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        overFourteenSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        termsOfServiceSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        privacyPolicySwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        marketingSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    func setupLayouts() {
        view.backgroundColor = .white
        //레이아웃 설정
        let views = [logoImage, nameField, genderSegmentControl, nicknameField, checkNicknameButton, birthdayField, emailField, agreeTitle, agreeBox, agreeBoxLine, allAgreeSwitch, overFourteenSwitch, termsOfServiceSwitch, privacyPolicySwitch, marketingSwitch, signUpButton, detailButton1, detailButton2, allAgreeText, overFourteenText, termsofServiceText, privacyPolicyText, marketingText]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 108),
            logoImage.heightAnchor.constraint(equalToConstant: 51),
            logoImage.widthAnchor.constraint(equalToConstant: 57),
            
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 15),
            nameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            nameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38),
            nameField.heightAnchor.constraint(equalToConstant: 40),
            
            genderSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderSegmentControl.topAnchor.constraint(equalTo: nameField.bottomAnchor),
            genderSegmentControl.heightAnchor.constraint(equalToConstant: 24),
            genderSegmentControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            genderSegmentControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38),
            
            nicknameField.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor, constant: 15),
            nicknameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            nicknameField.heightAnchor.constraint(equalToConstant: 32),
            nicknameField.rightAnchor.constraint(equalTo: checkNicknameButton.leftAnchor, constant: -4),
            
            checkNicknameButton.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor, constant: 15),
            checkNicknameButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38),
            checkNicknameButton.widthAnchor.constraint(equalToConstant: 80),
            checkNicknameButton.heightAnchor.constraint(equalToConstant: 32),
            
            birthdayField.topAnchor.constraint(equalTo: nicknameField.bottomAnchor, constant: 15),
            birthdayField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            birthdayField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38),
            birthdayField.heightAnchor.constraint(equalToConstant: 40),
            
            emailField.topAnchor.constraint(equalTo: birthdayField.bottomAnchor, constant: 15),
            emailField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            emailField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            
            agreeTitle.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 25),
            agreeTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            //69x17에서 75x25로 정정 요청
            agreeTitle.widthAnchor.constraint(equalToConstant: 75),
            agreeTitle.heightAnchor.constraint(equalToConstant: 25),
            
            agreeBox.topAnchor.constraint(equalTo: agreeTitle.bottomAnchor, constant: 10),
            agreeBox.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            agreeBox.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38),
            agreeBox.heightAnchor.constraint(equalToConstant: 143),
            
            allAgreeSwitch.topAnchor.constraint(equalTo: agreeBox.topAnchor, constant: 10),
            allAgreeSwitch.leftAnchor.constraint(equalTo: agreeBox.leftAnchor, constant: 13),
            allAgreeSwitch.heightAnchor.constraint(equalToConstant: 15),
            allAgreeSwitch.widthAnchor.constraint(equalToConstant: 15),
            
            allAgreeText.leftAnchor.constraint(equalTo: allAgreeSwitch.rightAnchor, constant: 4),
            allAgreeText.centerYAnchor.constraint(equalTo: allAgreeSwitch.centerYAnchor),
            allAgreeText.heightAnchor.constraint(equalToConstant: 20),
            allAgreeText.widthAnchor.constraint(equalToConstant: 100),
            
            agreeBoxLine.topAnchor.constraint(equalTo: allAgreeSwitch.bottomAnchor, constant: 9.5),
            agreeBoxLine.heightAnchor.constraint(equalToConstant: 1),
            agreeBoxLine.leftAnchor.constraint(equalTo: agreeBox.leftAnchor, constant: 13),
            agreeBoxLine.rightAnchor.constraint(equalTo: agreeBox.rightAnchor, constant: -19),
            
            overFourteenSwitch.topAnchor.constraint(equalTo: agreeBoxLine.bottomAnchor, constant: 9),
            overFourteenSwitch.leftAnchor.constraint(equalTo: agreeBox.leftAnchor, constant: 13),
            overFourteenSwitch.heightAnchor.constraint(equalToConstant: 15),
            overFourteenSwitch.widthAnchor.constraint(equalToConstant: 15),
            
            overFourteenText.leftAnchor.constraint(equalTo: overFourteenSwitch.rightAnchor, constant: 4),
            overFourteenText.centerYAnchor.constraint(equalTo: overFourteenSwitch.centerYAnchor),
            overFourteenText.heightAnchor.constraint(equalToConstant: 20),
            overFourteenText.widthAnchor.constraint(equalToConstant: 150),
            
            termsOfServiceSwitch.topAnchor.constraint(equalTo: overFourteenSwitch.bottomAnchor, constant: 8),
            termsOfServiceSwitch.leftAnchor.constraint(equalTo: agreeBox.leftAnchor, constant: 13),
            termsOfServiceSwitch.heightAnchor.constraint(equalToConstant: 15),
            termsOfServiceSwitch.widthAnchor.constraint(equalToConstant: 15),
            
            termsofServiceText.leftAnchor.constraint(equalTo: termsOfServiceSwitch.rightAnchor, constant: 4),
            termsofServiceText.centerYAnchor.constraint(equalTo: termsOfServiceSwitch.centerYAnchor),
            termsofServiceText.heightAnchor.constraint(equalToConstant: 20),
            termsofServiceText.widthAnchor.constraint(equalToConstant: 150),
            
            detailButton1.centerYAnchor.constraint(equalTo: termsofServiceText.centerYAnchor),
            detailButton1.rightAnchor.constraint(equalTo: agreeBox.rightAnchor, constant: -10),
            detailButton1.widthAnchor.constraint(equalToConstant: 46),
            detailButton1.heightAnchor.constraint(equalToConstant: 12),
            
            privacyPolicySwitch.topAnchor.constraint(equalTo: termsOfServiceSwitch.bottomAnchor, constant: 8),
            privacyPolicySwitch.leftAnchor.constraint(equalTo: agreeBox.leftAnchor, constant: 13),
            privacyPolicySwitch.heightAnchor.constraint(equalToConstant: 15),
            privacyPolicySwitch.widthAnchor.constraint(equalToConstant: 15),
            
            privacyPolicyText.leftAnchor.constraint(equalTo: privacyPolicySwitch.rightAnchor, constant: 4),
            privacyPolicyText.centerYAnchor.constraint(equalTo: privacyPolicySwitch.centerYAnchor),
            privacyPolicyText.heightAnchor.constraint(equalToConstant: 20),
            privacyPolicyText.widthAnchor.constraint(equalToConstant: 200),
            
            detailButton2.centerYAnchor.constraint(equalTo: privacyPolicyText.centerYAnchor),
            detailButton2.rightAnchor.constraint(equalTo: agreeBox.rightAnchor, constant: -10),
            detailButton2.widthAnchor.constraint(equalToConstant: 46),
            detailButton2.heightAnchor.constraint(equalToConstant: 12),
            
            
            marketingSwitch.topAnchor.constraint(equalTo: privacyPolicySwitch.bottomAnchor, constant: 8),
            marketingSwitch.leftAnchor.constraint(equalTo: agreeBox.leftAnchor, constant: 13),
            marketingSwitch.heightAnchor.constraint(equalToConstant: 15),
            marketingSwitch.widthAnchor.constraint(equalToConstant: 15),
            
            marketingText.leftAnchor.constraint(equalTo: marketingSwitch.rightAnchor, constant: 4),
            marketingText.centerYAnchor.constraint(equalTo: marketingSwitch.centerYAnchor),
            marketingText.heightAnchor.constraint(equalToConstant: 20),
            marketingText.widthAnchor.constraint(equalToConstant: 200),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.topAnchor.constraint(equalTo: agreeBox.bottomAnchor, constant: 20),
            signUpButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 34),
            signUpButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -38)
        ])
    }
    
    @objc func checkNicknameButtonTapped(_ sender: UIButton) {
        //서버에 닉네임 중복확인 요청
    }
    
    @objc func birthdayFieldTouchUp(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜 고르기", message: "날짜를 골라주세요", preferredStyle: .actionSheet)
        let formatter = DateFormatter()
        formatter.dateFormat = " yyyy년 MM월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        let ok = UIAlertAction(title: "선택 완료", style: .cancel) { action in
            self.birthdayField.setTitle("\(formatter.string(from: datePicker.date))", for: .normal)
        }
                
        alert.addAction(ok)
        
        let vc = UIViewController()
        vc.view = datePicker
        
        alert.setValue(vc, forKey: "contentViewController")
                
        present(alert, animated: true)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender == allAgreeSwitch {
            let isOn = sender.isOn
            overFourteenSwitch.isOn = isOn
            termsOfServiceSwitch.isOn = isOn
            privacyPolicySwitch.isOn = isOn
            marketingSwitch.isOn = isOn
        }
        
        let isRequiredSwitchOn = overFourteenSwitch.isOn && termsOfServiceSwitch.isOn && privacyPolicySwitch.isOn
        
        if isRequiredSwitchOn {
            signUpButton.backgroundColor = UIColor(red: 0.31, green: 0.58, blue: 0.98, alpha: 1.00)
        } else {
            signUpButton.backgroundColor = .gray
        }
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton) {
        //서버에 회원가입 요청
    }
    
    @objc func detailButton1Tapped(_ sender: UIButton) {
        
    }
    
    @objc func detailButton2Tapped(_ sender: UIButton) {
        
    }
    
}
