import Foundation

protocol MovieListViewProtocol: AnyObject {
    
    func success()
    func failure(error: BackendError)
}

protocol MovieListViewPresenterProtocol: AnyObject {
    
    var data: DataClass? { get set }
    var filtredData: [Category] { get }
    var filter: GroupType? { get set }
    
    init(view: MovieListViewProtocol, networkService: NetworkServiceProtocol, router: RouterPlaceProtocol)
    
    func getData()
    func tapOnData(data: Category?)
}

class MovieListPresenter: MovieListViewPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    let networkService: NetworkServiceProtocol!
    let router: RouterPlaceProtocol!
    var data: DataClass?
    
    var filter: GroupType? {
        didSet {
            view?.success()
        }
    }
    
    var filtredData: [Category] {
        switch filter {
        case .all, nil:
            return data?.categories ?? [Category]()
        default:
            return data?.categories?.filter({ $0.color == filter?.rawValue }) ?? [Category]()
        }
    }
    
    required init(view: MovieListViewProtocol, networkService: NetworkServiceProtocol, router: RouterPlaceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getData()
    }
    
    func getData() {
        
        networkService.get { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                self.data = model?.data
                self.view?.success()
                DataCaretaker.saveCategories(model?.data?.categories ?? [])
            case .failure(let error):
                self.view?.failure(error: error)
                self.data?.categories = DataCaretaker.loadCategories()
            }
        }
    }
    
    func tapOnData(data: Category?) {
        let objects = self.data?.objects?.filter({ $0.type == data?.type })
        router.showObjects(data: objects)
    }
}
