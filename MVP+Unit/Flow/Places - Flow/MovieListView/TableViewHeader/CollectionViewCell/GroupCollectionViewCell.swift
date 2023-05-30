//
//  GroupCollectionViewCell.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IDENTIFIER
    
    static let identifier = "GroupCollectionViewCell"
    
    //MARK: - UI
    
    private let titleLabel = CLabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected  {
                contentView.backgroundColor = CColor.custBlue
            } else {
                contentView.backgroundColor = CColor.custLightGray
            }
        }
    }
    
    //MARK: - CONSTRAINT
    
    private let factor: CGFloat = 10
    
    //MARK: - SET UI
    
    func setUI(text: String) {
        
        contentView.backgroundColor = CColor.custLightGray
        contentView.layer.cornerRadius = factor
        
        titleLabel.createLabel(
            text: text,
            fontType: FontType.monserattBold.value,
            fontSize: factor,
            textColor: CColor.custBlack,
            textAligment: .center
        )
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
