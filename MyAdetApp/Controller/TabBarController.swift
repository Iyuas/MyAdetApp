//
//  UITabBarController.swift
//  MyAdetApp
//
//  Created by Serdaly Muhammed on 16.12.2025.
//

import UIKit

class TabBarController: UIViewController{
    override func viewDidLoad() {
        let habitsVC = HabitListViewController()
        habitsVC.tabBarItem = UITabBarItem(
            title: "Habits",
            image: UIImage(systemName: "checkmark.circle"),
            tag: 0
        )
        
        let calendarVC = CalendarViewController()
        calendarVC.tabBarItem = UITabBarItem(
            title: "Calendar",
            image: UIImage(systemName: "calendar"),
            tag: 1
        )

        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            habitsVC,
            calendarVC
        ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tabBar = self.tabBarController!.tabBar
        let height: CGFloat = 70
        let bottomInset = view.safeAreaInsets.bottom

        tabBar.frame = CGRect(
            x: 20,
            y: view.frame.height - height - bottomInset - 10,
            width: view.frame.width - 40,
            height: height
        )

        tabBar.layer.cornerRadius = 28
        tabBar.layer.masksToBounds = true
    }

}

