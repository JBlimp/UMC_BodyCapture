import UIKit

class CustomButtonView: UIView {
    private let imageButton = UIButton()
    private let titleLabel = UILabel()

    // 초기화 메서드
    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        imageButton.setImage(image, for: .normal)
        titleLabel.text = title
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 레이아웃 설정 메서드
    private func setupLayout() {
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageButton)
        addSubview(titleLabel)
        
        // ImageView 레이아웃 설정
        NSLayoutConstraint.activate([
            imageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageButton.topAnchor.constraint(equalTo: topAnchor),
            imageButton.widthAnchor.constraint(equalToConstant: 40), // 이미지 크기 조정
            imageButton.heightAnchor.constraint(equalToConstant: 40), // 이미지 크기 조정
        ])
        
        // TitleLabel 레이아웃 설정
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 8), // 이미지와 타이틀 사이의 간격
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14) // 폰트 크기 조정
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        imageButton.addTarget(target, action: action, for: controlEvents)
    }
}
