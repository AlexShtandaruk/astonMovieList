import Foundation

protocol ObjectViewProtocol: AnyObject {
    
    func setData(data: [Object]?)
}

protocol ObjectPresenterProtocol: AnyObject {
    
    init(view: ObjectViewProtocol, networkService: NetworkServiceProtocol, data: [Object]?, router: RouterPlaceProtocol)
    
    func getData()
    
    func tapBack()
    
    func tapData(lon: Double, lat: Double)
}

class ObjectPresenter: ObjectPresenterProtocol {
    
    var data: [Object]?
    weak var view: ObjectViewProtocol?
    let networkService: NetworkServiceProtocol!
    let router: RouterPlaceProtocol!
    let alertService = AlertService()
    
    required init(view: ObjectViewProtocol, networkService: NetworkServiceProtocol, data: [Object]?, router: RouterPlaceProtocol) {
        self.view = view
        self.networkService = networkService
        self.data = data
        self.router = router
    }
    
    func getData() {
        view?.setData(data: data)
    }
    
    func tapBack() {
        router.popToRoot()
    }
    
    func tapData(lon: Double, lat: Double) {
        
    }
}

