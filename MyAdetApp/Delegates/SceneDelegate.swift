//
//  SceneDelegate.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 08.12.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
    func createTabBar() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.viewControllers = [createHabtiListNC(), createCalendarNC()]
        return tabBar
    }
    
    func createHabtiListNC() -> UINavigationController{
        let habitVC = HabitListViewController()
        habitVC.title = "Habit List"
        habitVC.tabBarItem.image = UIImage(systemName: "checkmark.circle")
        return UINavigationController(rootViewController: habitVC)
    }
    
    func createCalendarNC() -> UINavigationController{
        let calendar = CalendarViewController()
        calendar.title = "Calendar"
        calendar.tabBarItem.image = UIImage(systemName: "calendar")
        
        return UINavigationController(rootViewController: calendar)
    }
}
