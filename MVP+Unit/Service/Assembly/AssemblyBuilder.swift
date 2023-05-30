import UIKit


protocol AssemblyBuilderProtocol {
    
    // place - flow
    func createMainModule(router: RouterPlaceProtocol) -> UIViewController
    func createObjectModule(data: [Object]?, router: RouterPlaceProtocol) -> UIViewController
    
}

final class AssemblyBuiler: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterPlaceProtocol) -> UIViewController {
        let view = CategoryViewController()
        let networkService = NetworkService()
        let presenter = CategoryPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createObjectModule(data: [Object]?, router: RouterPlaceProtocol) -> UIViewController {
        let view = ObjectViewController()
        let networkService = NetworkService()
        let presenter = ObjectPresenter(view: view, networkService: networkService, data: data, router: router)
        view.presenter = presenter
        return view
    }
}
