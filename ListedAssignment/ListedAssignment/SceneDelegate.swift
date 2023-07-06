//
//  SceneDelegate.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 02/07/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func createMainNavigationController() -> UINavigationController {
        let netWorkManager: ObjectService = NetworkManager()
        let linksVC =  MainViewController(networkManager: netWorkManager)
        linksVC.tabBarItem = UITabBarItem(title: "Links", image: UIImage(systemName: "link"), tag: 0)
        return UINavigationController(rootViewController: linksVC)

    }
    
    func createNewsNavigationController() -> UINavigationController {
        let newsVC =  EmptyViewController()
        newsVC.tabBarItem = UITabBarItem(title: "Courses", image: UIImage(systemName: "book"), tag: 1)
        return UINavigationController(rootViewController: newsVC)

    }
    
    func createProfileNavigationController() -> UINavigationController {
        let newsVC =  EmptyViewController()
        newsVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return UINavigationController(rootViewController: newsVC)

    }
    
    func createSearchNavigationController() -> UINavigationController {
        let newsVC =  EmptyViewController()
        newsVC.tabBarItem = UITabBarItem(title: "Campaigns", image: UIImage(systemName: "megaphone"), tag: 1)
        return UINavigationController(rootViewController: newsVC)

    }
    
    func createWriteNavigationController() -> UINavigationController {
        let newsVC =  EmptyViewController()
        newsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 1)
        return UINavigationController(rootViewController: newsVC)

    }
    
    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .black
        tabBar.tabBar.backgroundColor = .white
        //UITabBar.appearance().barTintColor = .black
        tabBar.viewControllers = [createMainNavigationController(),                 createNewsNavigationController(),createWriteNavigationController(), createSearchNavigationController(), createProfileNavigationController()]
        return tabBar
    }
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

