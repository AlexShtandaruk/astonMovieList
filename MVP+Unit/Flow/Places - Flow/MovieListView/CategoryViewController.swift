import UIKit

class CategoryViewController: UIViewController {
    
    // MARK: - UI
    
    private let categoryTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - PROPERTIES
    
    var presenter: CategoryViewPresenterProtocol!
    private let header = CategoryTableViewHeader()
    private let alertService = AlertService()
    private lazy var subView = [
        categoryTableView
    ]
    
    //MARK: - CONSTRAINT
    
    private lazy var factor = view.bounds.width / 5
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        header.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - extension - CategoryViewProtocol

extension CategoryViewController: CategoryViewProtocol {
    
    func success() {
        categoryTableView.reloadData()
    }
    
    func failure(error: BackendError) {
        
        switch error {
        case    .information(let text, let code),
                .redirection(let text, let code),
                .authError(let text, let code),
                .clientError(let text, let code),
                .serverError(let text, let code),
                .unresolved(let text, let code):
            alertService.alertForUser(with: .failureNetwork, view: self, text: text, code: code)
        case .decodeError(description: let text):
            alertService.alertForUser(with: .failureNetwork, view: self, text: text, code: 0)
        }
    }
}

// MARK: - extension - UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let data = presenter.data?.categories?[indexPath.row]
        presenter.tapOnData(data: data)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return factor/1.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header.setUI()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return factor * 1.2
    }
}

// MARK: - extension - UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filtredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        let data = presenter.filtredData[indexPath.row]
        cell.setUI(
            title: data.name,
            count: data.count,
            color: data.color
        )
        return cell
    }
}

// MARK: - extension - ViewControllerProtocol

extension CategoryViewController: CategoryTableViewGroupDidSelected {
    
    func didSelectedModel(group: GroupType?) {
        presenter.filter = group
    }
}

// MARK: - extension - ViewControllerProtocol

extension CategoryViewController: ViewControllerProtocol {
    
    func setUI()  {
        
        view.backgroundColor = CColor.custBlack
        
        categoryTableView.translatesAutoresizingMaskIntoConstraints = false
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        categoryTableView.separatorInset = .zero
        categoryTableView.backgroundColor = CColor.custBlack
        categoryTableView.separatorColor = CColor.custDarkGray
        categoryTableView.tintColor = CColor.custDarkGray
        
        setView(subView: subView)
        setConstraint()
    }
    
    func setView(subView: [UIView]) {
        for i in subView { view.addSubview(i) }
    }
    
    func setConstraint()  {
        NSLayoutConstraint.activate([
            categoryTableView.topAnchor.constraint(equalTo: view.topAnchor),
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
