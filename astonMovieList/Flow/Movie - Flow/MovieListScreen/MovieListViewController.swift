import UIKit

final class MovieListViewController: UIViewController {
    
    // MARK: - UI
    
    private let movieListTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - PROPERTIES
    
    var presenter: MovieListViewPresenterProtocol!
    private let header = CategoryTableViewHeader()
    private let alertService = AlertService()
    private lazy var subView = [ movieListTableView ]
    
    //MARK: - CONSTRAINT
    
    private lazy var factor = view.bounds.width / 5
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        header.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        presenter.getData()
    }
}

// MARK: - extension - MovieListViewProtocol

extension MovieListViewController: MovieListViewProtocol {
    
    func success() {
        movieListTableView.reloadData()
    }
    
    func failure(error: BackendError) {
        
        switch error {
        case .information(let text, let code), .redirection(let text, let code), .authError(let text, let code), .clientError(let text, let code), .serverError(let text, let code), .unresolved(let text, let code):
            //just for saving time
            alertService.alertForUser(with: .failureNetwork, view: self, text: text, code: code)
        case .decodeError(description: let text):
            alertService.alertForUser(with: .failureNetwork, view: self, text: text, code: 0)
        }
    }
}

// MARK: - extension - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let data = presenter.filtredData[indexPath.row]
        presenter.tapOnData(data: data)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return factor * 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header.setUI()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return factor * 1.2
    }
}

// MARK: - extension - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filtredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
        let data = presenter.filtredData[indexPath.row]
        let arrayTime = data.runtime?.split(separator: " ")
        if let arrayTime = arrayTime {
            let currentTime = Int(arrayTime[0])
            let hours = (currentTime ?? 0) / 60
            let minutes = (currentTime ?? 0) % 60
            cell.setUI(title: data.title, hours: "\(hours)", minutes: "\(minutes)", year: data.year, rating: data.ratings?[0].value, imageLink: data.poster)
            return cell
        }
        cell.setUI(title: data.title, hours: "59", minutes: "59", year: data.year, rating: data.ratings?[0].value, imageLink: data.poster)
        return cell
    }
}

// MARK: - extension - ViewControllerProtocol

extension MovieListViewController: ViewControllerProtocol {
    
    func setUI()  {
        
        view.backgroundColor = CColor.custBlack
        movieListTableView.translatesAutoresizingMaskIntoConstraints = false
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        movieListTableView.separatorInset = .zero
        movieListTableView.backgroundColor = CColor.custBlack
        movieListTableView.separatorColor = .clear
        
        setView(view: view, subView: subView)
        setConstraint()
    }
    
    func setConstraint()  {
        NSLayoutConstraint.activate([
            movieListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - extension - CategoryTableViewGroupDidSelected

extension MovieListViewController: CategoryTableViewGroupDidSelected {
    
    func didSelectedModel(genre: Genre?) {
        presenter.filter = genre
    }
}
