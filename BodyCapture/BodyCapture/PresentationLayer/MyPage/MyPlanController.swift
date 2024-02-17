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
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }()
    
    let profileName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let profileHeight: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let profileWeight: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let goalweight: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let ddayview: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let ddaytext: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dday: UILabel = {
        let label = UILabel()
        
        return label
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
        //임시로 User 정보 입력
        currentUser?.fullName = "이준석"
        currentUserGoal = requestUserGoalHeightWeight()
        view.backgroundColor = .white
    }
    
    func setupLayouts() {
        let safeArea = view.safeAreaLayoutGuide
        let views = [profileImage, profileName, profileHeight, profileHeight, goalweight, ddayview, ddaytext, dday]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
            
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
}
