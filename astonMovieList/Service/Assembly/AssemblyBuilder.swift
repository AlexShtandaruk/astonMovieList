import UIKit


protocol AssemblyBuilderProtocol {
    
    // place - flow
    func createMovieListModule(router: RouterMovieProtocol) -> UIViewController
    func createObjectModule(data: Movie?, router: RouterMovieProtocol, completionAuth: @escaping () -> Void) -> UIViewController
    func createLogInModule(router: RouterAuthProtocol, completionAuth: @escaping () -> Void) -> UIViewController
    
}

final class AssemblyBuiler: AssemblyBuilderProtocol {
    
    // Movie list assembly
    
    func createMovieListModule(router: RouterMovieProtocol) -> UIViewController {
        let view = MovieListViewController()
        let networkService = NetworkService()
        let presenter = MovieListPresenter(
            view: view,
            networkService: networkService,
            router: router
        )
        view.presenter = presenter
        return view
    }
    
    func createObjectModule(data: Movie?, router: RouterMovieProtocol, completionAuth: @escaping () -> Void) -> UIViewController {
        let view = MovieDetailViewController()
        let networkService = NetworkService()
        let presenter = MovieDetailPresenter(
            view: view, networkService: networkService,
            data: data,
            router: router,
            completionAuth: completionAuth
        )
        view.presenter = presenter
        return view
    }
    
    // Auth assembly
    
    func createLogInModule(router: RouterAuthProtocol, completionAuth: @escaping () -> Void) -> UIViewController {
        let view = LogInViewController()
        let presenter = LogInPresenter(
            view: view,
            router: router,
            completionAuth: completionAuth
        )
        view.presenter = presenter
        return view
    }
}
