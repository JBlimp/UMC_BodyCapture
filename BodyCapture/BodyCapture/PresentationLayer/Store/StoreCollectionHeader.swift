//
//  StoreCollectionHeader.swift
//  BodyCapture
//
//  Created by 하상준 on 2/15/24.
//

import UIKit

protocol CollectionHeaderDelegate: AnyObject {
    func selectDistrictButtonTapped()
}

class StoreCollectionHeader: UICollectionReusableView {
    static let identifier = "CollectionViewHeader"
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "choosingRegion"), for: .normal)
        btn.addTarget(self, action: #selector(choosingRegionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    weak var delegate: CollectionHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func choosingRegionButtonTapped() {
        print("버튼 눌렸우")
        delegate?.selectDistrictButtonTapped()
    }
}

extension StoreController: CollectionHeaderDelegate {
    func selectDistrictButtonTapped() {
        if let presentationController = pickerViewController.presentationController as? UISheetPresentationController {
                    presentationController.detents = [.medium()]
                }
        subscribeToPickerSelection()
        self.present(pickerViewController, animated: true)
    }
}
