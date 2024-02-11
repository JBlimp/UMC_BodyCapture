//
//  HeartControllerStoreExtension.swift
//  BodyCapture
//
//  Created by junseok on 2/11/24.
//

import UIKit

extension HeartController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyInfoCell.identifier, for: indexPath) as! CompanyInfoCell
        let companyInfo = companyInfos[indexPath.item]
        cell.configure(with: companyInfo)
        
        cell.onTap = {
            if let url = companyInfo.storeURL {
                UIApplication.shared.open(url)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == companyInfos.count - 1 { // Check if the last cell is being displayed
            // Load more data and update the collection view
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = storeSectionInsets.left * (storeItemsPerLow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / storeItemsPerLow

        let paddingHeight = storeSectionInsets.top * (storeItemsPerColumn + 1)
        let availableHeight = collectionView.frame.height - paddingHeight - (storeSectionInsets.bottom * (storeItemsPerColumn + 1))
        let heightPerItem = availableHeight / storeItemsPerColumn

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return storeSectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return storeMinimumLineSpacing // 행 사이의 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return storeMinimumInteritemSpacing // 열 사이의 간격
    }

}
