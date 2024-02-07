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
        
        for (index, (title, image)) in zip(titles, images).enumerated() {
            let customButtonView = CustomButtonView(image: image, title: title)
            customButtonView.tag = index
            customButtonView.delegate = self
            buttonsStackView.addArrangedSubview(customButtonView)
        }
        

        //layout
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
    
    @objc func radioButtonTapped(_ sender: CustomButtonView) {
        print("Radio button tapped: \(sender.tag)")
        selectedButtonTag = sender.tag
        updateButtonSelectionStates()
    }


    func updateButtonSelectionStates() {
        for case let button as CustomButtonView in buttonsStackView.arrangedSubviews {
            button.isSelected = (button.tag == selectedButtonTag)
        }
    }
    
    //collectionview configure
    func configureStoreCollection() {
        
    }
}

extension StoreController: CustomButtonViewDelegate {
    func customButtonViewTapped(_ view: CustomButtonView) {
        print("Button tapped: \(view.tag)")
        radioButtonTapped(view)
    }
}
