import UIKit
import Kingfisher

class CompanyInfoCell: UICollectionViewCell {
    static let identifier = "CompanyInfoCell"
    
    var onTap: (() -> Void)?

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        // Additional image view styling
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // Initialize subviews and layout constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
        
        applyConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let photoImageViewHeightConstraint = photoImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        photoImageViewHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            // PhotoImageView constraints
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageViewHeightConstraint,
            
            // NameLabel constraints
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8), // Adjust spacing as needed
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        nameLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func configure(with companyInfo: CompanyInfo) {
        nameLabel.text = companyInfo.name
        
        let placeholderImage = UIImage(systemName: "figure.run") // 기본 이미지
        if let url = companyInfo.imageURL {
            photoImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            photoImageView.image = placeholderImage
        }
    }
    
    @objc private func handleTap() {
        onTap?()
    }

}

