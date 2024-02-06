//
//  StoreController+Layout.swift
//  BodyCapture
//
//  Created by 하상준 on 2/6/24.
//

import UIKit

extension StoreController {
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
            containerStoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerStoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerStoreView.heightAnchor.constraint(equalToConstant: 100),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: containerStoreView.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: containerStoreView.centerYAnchor)
        ])

    }
}
