import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER CELL
    
    static let identifier = "CategoryTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel = CLabel()
    private let runtimeLabel = CLabel()
    private let yearLabel = CLabel()
    private let ratingLabel = CLabel()
    private let starImageView = CImageView()
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
        movieConteinerView,
        movieImageView,
        movieActivityIndicator,
        starImageView,
        ratingLabel
    ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    private lazy var imageSize = factor * 2
    
    // MARK: - SET UI METHOD'S
    
    func setUI(title: String?, hours: String?, minutes: String?, year: String?, rating: String?, imageLink: String?) {
        
        contentView.backgroundColor = CColor.custBlack
        
        movieActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        movieActivityIndicator.startAnimating()
        movieActivityIndicator.isHidden = false
        movieActivityIndicator.color = .white
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.createLabel(
            text: title,
            fontType: FontType.monserattBold.value,
            fontSize: factor/4,
            textColor: CColor.custRed,
            textAligment: .left
        )
        runtimeLabel.createLabel(
            text: nil,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4.5,
            textColor: .clear,
            textAligment: .left
        )
        let descRunTimeText = Constant.duration.localized() + " "
        let currentTimeText = (hours ?? "") + " " + Constant.hours.localized() + " " + (minutes ?? "") + " " + Constant.minutes.localized()
        let textArray = [ descRunTimeText, currentTimeText ]
        let textColors = [ CColor.custRed, CColor.custWhite ]
        runtimeLabel.attributedText = runtimeLabel.getAttributedString(
            arrayText: textArray,
            arrayColors: textColors
        )
        yearLabel.createLabel(
            text: (year ?? "") + " " + Constant.year.localized(),
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4.5,
            textColor: CColor.custLightGray,
            textAligment: .left
        )
        ratingLabel.createLabel(
            text: rating,
            fontType: FontType.monserattBold.value,
            fontSize: factor/4.5,
            textColor: CColor.yellow,
            textAligment: .left
        )
        starImageView.createImageView(
            cornerRadius: 0,
            contentMode: .scaleToFill
        )
        starImageView.image = UIImage(
            named: ProjectConstant.ProjectImages.star
        )
        movieConteinerView.createView(
            cornerRadius: 0
        )
        movieImageView.createImageView(
            cornerRadius: imageSize / 5,
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
            movieConteinerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieConteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spasing),
            movieConteinerView.heightAnchor.constraint(equalToConstant: imageSize),
            movieConteinerView.widthAnchor.constraint(equalToConstant: imageSize),
            
            movieImageView.topAnchor.constraint(equalTo: movieConteinerView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: movieConteinerView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: movieConteinerView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: movieConteinerView.bottomAnchor),
            
            movieActivityIndicator.centerXAnchor.constraint(equalTo: movieConteinerView.centerXAnchor),
            movieActivityIndicator.centerYAnchor.constraint(equalTo: movieConteinerView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieConteinerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieConteinerView.trailingAnchor, constant: spasing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spasing),
            titleLabel.heightAnchor.constraint(equalToConstant: spasing * 2),
            
            runtimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            runtimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            runtimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            runtimeLabel.heightAnchor.constraint(equalToConstant: spasing * 2),
            
            yearLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.centerXAnchor, constant: -spasing/2),
            yearLabel.bottomAnchor.constraint(equalTo: movieConteinerView.bottomAnchor),
            
            starImageView.leadingAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            starImageView.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: imageSize/4),
            starImageView.heightAnchor.constraint(equalToConstant: imageSize/4),
            
            ratingLabel.topAnchor.constraint(equalTo: yearLabel.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: spasing/4),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: yearLabel.bottomAnchor),
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

// MARK: - Сonstant's

extension MovieListTableViewCell {
    struct Constant {
        static let year = "movieListTableViewCell.year"
        static let hours = "movieListTableViewCell.hours"
        static let minutes = "movieListTableViewCell.minutes"
        static let duration = "movieListTableViewCell.duration"
    }
}
