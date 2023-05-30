//
//  ObjectTableViewHeader.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

class ObjectTableViewHeader: UIView {
    
    //MARK: - UI
    
    private let conteinerView = CView()
    private let titleLabel = CLabel()
    
    // MARK: - CONSTRAINT
    
    private lazy var factor: CGFloat = 10
    
    // MARK: - SET UI
    
    func setUI() -> UIView {
        
        conteinerView.backgroundColor = CColor.custBlack
        conteinerView.createView(
            cornerRadius: 0
        )
        titleLabel.createLabel(
            text: Constant.Object.HeaderTableView.title.localized(),
            fontType: FontType.monserattBold.value,
            fontSize: factor*3,
            textColor: CColor.custWhite,
            textAligment: .left
        )
        
        setView()
        setConstraint()
        
        return self
    }
    
    // MARK: - SET VIEW
    
    private func setView() {
        self.addSubview(conteinerView)
        conteinerView.addSubview(titleLabel)
    }
    
    // MARK: - CONSTRAINT
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            conteinerView.topAnchor.constraint(equalTo: self.topAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: factor),
            titleLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
    }
}
