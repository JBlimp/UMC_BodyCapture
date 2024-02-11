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
    
    //collectionview configure
    func configureStoreCollection() {
        view.addSubview(storeCollection)
        storeCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storeCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            storeCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            storeCollection.topAnchor.constraint(equalTo: containerStoreView.bottomAnchor, constant: 10),
            storeCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 스크롤 방향을 수평으로 설정
        layout.minimumLineSpacing = 0 // 아이템 간 간격을 0으로 설정
        layout.minimumInteritemSpacing = 0 // 행 간 간격을 0으로 설정
        storeCollection.collectionViewLayout = layout
        storeCollection.isPagingEnabled = true // 페이징 활성화
        storeCollection.backgroundColor = ThemeColor.blue1
    }
    
    
    
}

extension StoreController: CustomButtonViewDelegate {
    // CustomButtonViewDelegate 메서드 구현
    func customButtonViewTapped(_ view: CustomButtonView) {
        print("Button tapped: \(view.tag)")
        radioButtonTapped(view)
        
        companyInfoRepository.fetchCompanyInfos(categoryIndex: view.tag) { [weak self] newCompanyInfos in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.storeCollection.reloadData()
                
                if newCompanyInfos.isEmpty {
                    print("No company info was fetched. Handling fallback scenario.")
                } else {
                    self.companyInfos = newCompanyInfos
                }
            }
        }
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
}
//MARK: - collectionView 구현

extension StoreController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyInfoCell.identifier, for: indexPath) as! CompanyInfoCell
        let companyInfo = companyInfos[indexPath.item]
        cell.configure(with: companyInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == companyInfos.count - 1 { // Check if the last cell is being displayed
            // Load more data and update the collection view
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        let paddingHeight = sectionInsets.top * (itemsPerColumn + 1)
        let availableHeight = collectionView.frame.height - paddingHeight - (sectionInsets.bottom * (itemsPerColumn + 1))
        let heightPerItem = availableHeight / itemsPerColumn

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing // 행 사이의 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing // 열 사이의 간격
    }

}
