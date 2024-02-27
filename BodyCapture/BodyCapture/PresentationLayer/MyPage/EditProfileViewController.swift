
import UIKit
import AuthenticationServices
import KakaoSDKUser
import GoogleSignIn

class EditProfileViewController: UIViewController {
    var currentUser: User?
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor(hex: "838383"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(logoutButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let titleText: UILabel = {
        let label = UILabel()
        label.text = "정보수정"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let nicknameText: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let genderText: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let birthdayText: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nameText: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let phoneText: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let purchaseText: UILabel = {
        let label = UILabel()
        label.text = "결제수단"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nicknameButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: "5095FA"), for: .normal)
        button.addTarget(self, action: #selector(nicknameButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let genderButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: "5095FA"), for: .normal)
        button.addTarget(self, action: #selector(genderButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    let birthdayButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: "5095FA"), for: .normal)
        button.addTarget(self, action: #selector(birthdayButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let nameButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: "5095FA"), for: .normal)
        button.addTarget(self, action: #selector(nameButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let phoneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: "5095FA"), for: .normal)
        button.addTarget(self, action: #selector(phoneButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let purchaseButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: "5095FA"), for: .normal)
        button.addTarget(self, action: #selector(purchaseButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    let line1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "979BA1")
        return view
    }()
    
    let line2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "979BA1")
        return view
    }()
    
    let line3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "979BA1")
        return view
    }()
    
    let line4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "979BA1")
        return view
    }()
    
    let line5: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "979BA1")
        return view
    }()
    
    let line6: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "979BA1")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUI()
    }
    
    func configureView() {
        self.currentUser?.socialIsWhat = "google"
        self.currentUser?.fullName = "이준석"
        self.currentUser?.birthday = "2000-06-07"
        self.currentUser?.gender = "남성"
        self.currentUser?.phone = "010-9170-8929"
        self.currentUser?.nickname = "JBlimp"
        
        nicknameButton.setTitle((self.currentUser?.nickname)! + " >", for: .normal)
        nameButton.setTitle((self.currentUser?.fullName)! + " >", for: .normal)
        genderButton.setTitle((self.currentUser?.gender)! + " >", for: .normal)
        birthdayButton.setTitle((self.currentUser?.birthday)! + " >", for: .normal)
        phoneButton.setTitle((self.currentUser?.phone)! + " >", for: .normal)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        let views = [logoutButton, titleText, nicknameText, genderText, birthdayText, nameText, phoneText, purchaseText, nicknameButton, genderButton, birthdayButton, nameButton, phoneButton, purchaseButton, line1, line2, line3, line4, line5, line6]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 42),
            titleText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 18),
            titleText.heightAnchor.constraint(equalToConstant: 35),
            
            nicknameText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 40),
            nicknameText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            nicknameText.heightAnchor.constraint(equalToConstant: 23),
            
            nicknameButton.centerYAnchor.constraint(equalTo: nicknameText.centerYAnchor),
            nicknameButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            nicknameButton.heightAnchor.constraint(equalToConstant: 23),
            
            genderText.topAnchor.constraint(equalTo: nicknameText.bottomAnchor, constant: 40),
            genderText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            genderText.heightAnchor.constraint(equalToConstant: 23),
            
            genderButton.centerYAnchor.constraint(equalTo: genderText.centerYAnchor),
            genderButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            genderButton.heightAnchor.constraint(equalToConstant: 23),
            
            birthdayText.topAnchor.constraint(equalTo: genderText.bottomAnchor, constant: 40),
            birthdayText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            birthdayText.heightAnchor.constraint(equalToConstant: 23),
            
            birthdayButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            birthdayButton.centerYAnchor.constraint(equalTo: birthdayText.centerYAnchor),
            birthdayButton.heightAnchor.constraint(equalToConstant: 23),
            
            nameText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            nameText.topAnchor.constraint(equalTo: birthdayText.bottomAnchor, constant: 40),
            nameText.heightAnchor.constraint(equalToConstant: 23),
            
            nameButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            nameButton.centerYAnchor.constraint(equalTo: nameText.centerYAnchor),
            nameButton.heightAnchor.constraint(equalToConstant: 23),
            
            phoneText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            phoneText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 40),
            phoneText.heightAnchor.constraint(equalToConstant: 23),
            
            phoneButton.centerYAnchor.constraint(equalTo: phoneText.centerYAnchor),
            phoneButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            phoneButton.heightAnchor.constraint(equalToConstant: 23),
            
            purchaseText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            purchaseText.topAnchor.constraint(equalTo: phoneText.bottomAnchor, constant: 40),
            purchaseText.heightAnchor.constraint(equalToConstant: 23),
            
            purchaseButton.centerYAnchor.constraint(equalTo: purchaseText.centerYAnchor),
            purchaseButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            purchaseButton.heightAnchor.constraint(equalToConstant: 23),
            
            logoutButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: purchaseText.bottomAnchor, constant: 75),
            
            line1.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            line1.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            line1.heightAnchor.constraint(equalToConstant: 1),
            line1.topAnchor.constraint(equalTo: nicknameText.bottomAnchor, constant: 20),
            
            line2.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            line2.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            line2.heightAnchor.constraint(equalToConstant: 1),
            line2.topAnchor.constraint(equalTo: genderText.bottomAnchor, constant: 20),
            
            line3.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            line3.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            line3.heightAnchor.constraint(equalToConstant: 1),
            line3.topAnchor.constraint(equalTo: birthdayText.bottomAnchor, constant: 20),
            
            line4.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            line4.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            line4.heightAnchor.constraint(equalToConstant: 1),
            line4.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20),
            
            line5.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            line5.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            line5.heightAnchor.constraint(equalToConstant: 1),
            line5.topAnchor.constraint(equalTo: phoneText.bottomAnchor, constant: 20),
            
            line6.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            line6.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -21),
            line6.heightAnchor.constraint(equalToConstant: 1),
            line6.topAnchor.constraint(equalTo: purchaseText.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func logoutButtonTouchUpInside() {
        let socialIsWhat = currentUser?.socialIsWhat
        
        //현재 사용자 정보와 UserDefaults에 저장된 로그인 정보가 다를 경우 UserDefaults 초기화후 앱 강제종료
        if socialIsWhat == UserDefaults.standard.string(forKey: "socialIsWhat") {
            forceRestart()
        }
        
        if socialIsWhat == "kakao" {
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("logout() success.")
                    
                    // 최초 화면으로
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginNavController = LoginViewController()
                    UIApplication.shared.keyWindow?.rootViewController = loginNavController
                }
            }
        } else if socialIsWhat == "google" {
            GIDSignIn.sharedInstance.signOut()
            //최초 화면으로
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginNavController = LoginViewController()
            UIApplication.shared.keyWindow?.rootViewController = loginNavController
            
        } else if socialIsWhat == "apple" {
            
        } else {
            forceRestart()
        }
    }
    
    func forceRestart() {
        let popup = UIAlertController(title: "오류가 발생했습니다", message: "앱을 종료합니다. 다시 로그인해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: alertHandler(_: ))
        popup.addAction(action)
        self.present(popup, animated: true)
    }
    
    func alertHandler(_ action: UIAlertAction) {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
        exit(0)
    }
    
    func sendEditProfileToServer() {
        //서버로 수정된 프로필 정보 전송
    }
    
    @objc func nicknameButtonTouchUpInside() {
        let popup = UIAlertController(title: "닉네임 변경", message: "닉네임을 입력해주세요", preferredStyle: .alert)
        popup.addTextField{ (TextField) in
            TextField.placeholder = self.currentUser?.nickname
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            if let text = popup.textFields?[0].text {
                self.currentUser?.nickname = text
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        popup.addAction(okAction)
        popup.addAction(cancelAction)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func genderButtonTouchUpInside() {
        let popup = UIAlertController(title: "성별", message: "성별을 선택해주세요", preferredStyle: .alert)

        let option1Action = UIAlertAction(title: "남성", style: .default) { (_) in
            // 옵션 1 선택 시 실행할 코드를 여기에 작성합니다.
            self.currentUser?.gender = "남성"
        }

        let option2Action = UIAlertAction(title: "여성", style: .default) { (_) in
            // 옵션 2 선택 시 실행할 코드를 여기에 작성합니다.
            self.currentUser?.gender = "여성"
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        popup.addAction(option1Action)
        popup.addAction(option2Action)
        popup.addAction(cancelAction)

        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func birthdayButtonTouchUpInside() {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            let date = self.datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let nextdate = dateFormatter.string(from: date) + " >"
            self.currentUser?.birthday = nextdate
            self.birthdayButton.setTitle(nextdate, for: .normal)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func nameButtonTouchUpInside() {
        let popup = UIAlertController(title: "소셜 로그인", message: "소셜에서 설정된 이름이 표시됩니다", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        popup.addAction(okAction)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func phoneButtonTouchUpInside() {
        let popup = UIAlertController(title: "전화번호 변경", message: "전화번호를 입력해주세요(-   제외)", preferredStyle: .alert)
        popup.addTextField{ (TextField) in
            TextField.placeholder = self.currentUser?.phone
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            if let text = popup.textFields?[0].text {
                //텍스트 처리
                self.currentUser?.phone = text
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        popup.addAction(okAction)
        popup.addAction(cancelAction)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func purchaseButtonTouchUpInside() {
        
    }
}

// #if DEBUG
// import SwiftUI
//
// struct VCPreView: PreviewProvider {
//     static var previews: some View {
//         EditProfileViewController().toPreview()
//     }
// }
// #endif
