
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Called when application is opened
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Use this window as opposed to main storyboard
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        return true
    }
    
    // Called when application will pause
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    // Called when application will enter background
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    // Called when application will enter foreground
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    // Called when application is resumed from a pause
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    // Called when application is about to terminate
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
}

