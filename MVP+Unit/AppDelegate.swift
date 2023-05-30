import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuiler()
        let router = RouterPlace(
            navigationController: navigationController,
            assemblyBuilder: assemblyBuilder
        )
        router.initialViewController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
