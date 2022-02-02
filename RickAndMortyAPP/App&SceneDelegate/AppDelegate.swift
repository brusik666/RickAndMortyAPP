import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var dataBase = DataBase()
    lazy var networkManager = ApiRequestsController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 50_000_000, diskCapacity: 100_000_000, diskPath: temporaryDirectory)
        URLCache.shared = urlCache
        
        dataBase.loadAllData()
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}



