import UIKit

protocol CustomButtonViewDelegate: AnyObject {
    func customButtonViewTapped(_ view: CustomButtonView)
}

class CustomButtonView: UIView {
    weak var delegate: CustomButtonViewDelegate?
    
    private let imageButton = UIButton()
    private let titleLabel = UILabel()
    private let selectionIndicator = UIView()
    var isSelected: Bool = false {
        didSet {
            selectionIndicator.isHidden = !isSelected
        }
    }
    var selectedButtonTag: Int?

    // 초기화 메서드
    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        imageButton.setImage(image, for: .normal)
        titleLabel.text = title
        isSelected = false
        
        setupLayout()
        addTapGestureRecognizer() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //토글
    
    // 레이아웃 설정 메서드
    private func setupLayout() {
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicator.backgroundColor = ThemeColor.blue4
        
        imageButton.isUserInteractionEnabled = false
        
        addSubview(imageButton)
        addSubview(titleLabel)
        addSubview(selectionIndicator)
        
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
        
        NSLayoutConstraint.activate([
            selectionIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectionIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            selectionIndicator.widthAnchor.constraint(equalToConstant: 16), // 선택 인디케이터의 크기 조정
            selectionIndicator.heightAnchor.constraint(equalToConstant: 3), // 선택 인디케이터의 크기 조정
        ])

        selectionIndicator.isHidden = true // 초기 상태는 숨김으로 설정
    }
    
    // 초기화 메서드 내 또는 별도 메서드로 탭 제스처 인식자 추가
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func viewTapped() {
        delegate?.customButtonViewTapped(self)
    }
    

}
