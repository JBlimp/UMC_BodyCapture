//
//  CityTableCell.swift
//  BodyCapture
//
//  Created by 하상준 on 2/16/24.
//

import UIKit

class CityTableCell: UITableViewCell {
    
    static let identifier = "CityTableCell"
    
    let cityName = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = ThemeColor.gray2
        return t
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentView() {
        contentView.addSubview(cityName)
        NSLayoutConstraint.activate([
            cityName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
}
