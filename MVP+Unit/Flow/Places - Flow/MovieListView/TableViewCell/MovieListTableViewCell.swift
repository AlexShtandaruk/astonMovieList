//Экран ленты фильмов. Тейбл вью, где на ячейке постер фильма, название, год, время в формате 2 h 10 m. Фильмы должны быть отсортированы по какому либо правилу. Например от новее к более старому

import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER CELL
    
    static let identifier = "CategoryTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel = CLabel()
    private let runtimeLabel = CLabel()
    private let yearLabel = CLabel()
    private let movieImageView = CImageView()
    private let movieConteinerView = CView()
    private let movieActivityIndicator = UIActivityIndicatorView()
    private var movieImage: UIImage? {
        didSet {
            movieImageView.image = movieImage
            movieActivityIndicator.stopAnimating()
            movieActivityIndicator.isHidden = true
        }
    }
    
    // MARK: - PROPERTIES
    
    private let networkService = NetworkService()
    private lazy var subView = [
        titleLabel,
        runtimeLabel,
        yearLabel,
        movieImageView
    ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    private lazy var imageSize = factor * 2
    
    // MARK: - SET UI METHOD'S

    func setUI(title: String?, runtime: String?, year: String?, imageLink: String?) {
        
        contentView.backgroundColor = CColor.custBlack
        
        titleLabel.createLabel(
            text: title,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4,
            textColor: CColor.custRed,
            textAligment: .left
        )
        runtimeLabel.createLabel(
            text: runtime,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4,
            textColor: CColor.custRed,
            textAligment: .left
        )
        yearLabel.createLabel(
            text: year,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4,
            textColor: CColor.custRed,
            textAligment: .left
        )
        movieImageView.createImageView(
            cornerRadius: imageSize / 3,
            contentMode: .scaleToFill
        )
        fetchImage(
            imageLink: imageLink
        )
        setView(
            subView: subView
        )
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        
        let spasing = factor / 3
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spasing),
            movieImageView.heightAnchor.constraint(equalToConstant: imageSize),
            movieImageView.widthAnchor.constraint(equalToConstant: imageSize*1.5),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: spasing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spasing),
            titleLabel.bottomAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            
            runtimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            runtimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            runtimeLabel.trailingAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            runtimeLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            
            yearLabel.topAnchor.constraint(equalTo: runtimeLabel.topAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: runtimeLabel.bottomAnchor),
        ])
    }
    
    // MARK: - Fetch image from model link
    
    private func fetchImage(imageLink: String?) {
        guard let url = URL(string: imageLink ?? String()) else { return }
        networkService.fetchImageData(from: url) { [weak self] image in
            guard let self = self else { return }
            self.movieImage = image
        }
    }

}
