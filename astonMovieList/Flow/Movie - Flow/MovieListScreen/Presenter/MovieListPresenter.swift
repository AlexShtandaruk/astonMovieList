import Foundation

// MARK: - Input

protocol MovieListViewProtocol: AnyObject {
    
    func success()
    func failure(error: BackendError)
}

// MARK: - Output

protocol MovieListViewPresenterProtocol: AnyObject {
    
    var data: [Movie] { get set }
    var filtredData: [Movie] { get }
    var filter: Genre? { get set }
    
    init(view: MovieListViewProtocol, networkService: NetworkServiceProtocol, router: RouterMovieProtocol)
    
    func getData()
    func tapOnData(data: Movie?)
}

// MARK: - List of movie

fileprivate enum MovieList: String, CaseIterable {
    
    case movieOne = "tt3896198"
    case movieTwo = "tt0120737"
    case movieThree = "tt0265086"
    case movieFour = "tt0093058"
    case movieFive = "tt0111161"
    case movieSix = "tt0068646"
    case movieSeven = "tt0108052"
    case movieEight = "tt0109830"
    case movieNine = "tt1375666"
    case movieTen = "tt0133093"
    case movieElewen = "tt0120815"
    case movieTwelve = "tt0110357"
}

// MARK: - Movie list presenter

final class MovieListPresenter: MovieListViewPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    let networkService: NetworkServiceProtocol!
    let router: RouterMovieProtocol!
    var data: [Movie] = []
    
    var filter: Genre? {
        didSet { view?.success() }
    }
    
    var filtredData: [Movie] {
        switch filter {
        case .all, nil:
            return data.sorted {
                let frstValue = Int($0.year ?? "0")
                let scndValue = Int($1.year ?? "0")
                return (frstValue ?? Int()) < (scndValue ?? Int())
            }
        default:
            return data.filter {
                $0.genre?.contains(filter?.rawValue ?? "") == true
            }
        }
    }
    
    required init(view: MovieListViewProtocol, networkService: NetworkServiceProtocol, router: RouterMovieProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getData() {
        
        let group = DispatchGroup()
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        var data: [Movie] = []
        
        for film in MovieList.allCases {
            group.enter()
            networkService.getMovieData(film: film.rawValue) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let model):
                    if let model = model {
                        queue.addOperation {
                            data.append(model)
                        }
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                    data = DataCaretaker.loadMovieList() ?? []
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.data = data
            self.view?.success()
            DataCaretaker.saveMovieList(data)
        }
    }
    
    func tapOnData(data: Movie?) {
        router.showObjects(data: data)
    }
}



//let objects = self.data?.objects?.filter({ $0.type == data?.type })
//router.showObjects(data: objects)
