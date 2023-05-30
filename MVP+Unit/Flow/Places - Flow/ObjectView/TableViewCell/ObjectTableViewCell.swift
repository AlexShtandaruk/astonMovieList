//
//  ObjectTableViewCell.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

class ObjectTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER CELL
    
    static let identifier = "ObjectTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel = CLabel()
    private let descriptionLabel = CLabel()
    private let objectImageView = CImageView()
    
    private let objectConteinerView = CView()
    private let activityIndicator = UIActivityIndicatorView()
    var objectImage: UIImage? {
        didSet {
            objectImageView.image = objectImage
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    // MARK: - PROPERTIES
    
    private let networkService = NetworkService()
    private lazy var subView = [
        objectConteinerView,
        objectImageView,
        activityIndicator,
        titleLabel,
        descriptionLabel
    ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    
    // MARK: - SET UI

    func setUI(title: String?, description: String?, imageLink: String?) {
        
        contentView.backgroundColor = CColor.custBlack
        
        titleLabel.createLabel(
            text: title,
            fontType: FontType.monserattBold.value,
            fontSize: factor/4,
            textColor: CColor.custWhite,
            textAligment: .left
        )
        descriptionLabel.lineBreakMode = .byCharWrapping
        descriptionLabel.numberOfLines = 2
        descriptionLabel.setLineHeight(
            lineHeight: factor/12
        )
        descriptionLabel.createLabel(
            text: description,
            fontType: FontType.monserattBold.value,
            fontSize: factor/5,
            textColor: CColor.custWhite,
            textAligment: .left
        )
        objectConteinerView.createView(
            cornerRadius: 0
        )
        objectImageView.createImageView(
            image: String(),
            cornerRadius: factor/5,
            contentMode: .scaleToFill
        )
        
        guard let url = URL(string: imageLink ?? String()) else { return }
        networkService.fetchImageData(from: url) { [weak self] image in
            self?.objectImage = image
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.color = .white
        
        setView(subView: subView)
        setConstraint()
    }
    
    private func setView(
        subView: [UIView]
    ) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        let spasing = factor / 5
        let imageSize = factor * 2
        NSLayoutConstraint.activate([
            objectConteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spasing),
            objectConteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spasing),
            objectConteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spasing),
            objectConteinerView.widthAnchor.constraint(equalToConstant: imageSize),
            
            objectImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spasing),
            objectImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spasing),
            objectImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spasing),
            objectImageView.widthAnchor.constraint(equalToConstant: imageSize),
            
//            objectImageView.topAnchor.constraint(equalTo: objectConteinerView.topAnchor),
//            objectImageView.bottomAnchor.constraint(equalTo: objectConteinerView.bottomAnchor),
//            objectImageView.leadingAnchor.constraint(equalTo: objectConteinerView.leadingAnchor),
//            objectImageView.bottomAnchor.constraint(equalTo: objectConteinerView.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: objectConteinerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: objectConteinerView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: objectConteinerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: objectConteinerView.centerYAnchor, constant: -spasing),
            titleLabel.leadingAnchor.constraint(equalTo: objectConteinerView.trailingAnchor, constant: spasing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spasing),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

}

