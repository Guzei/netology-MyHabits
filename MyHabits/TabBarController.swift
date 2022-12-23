//
//  TabBarController.swift
//  MyHabits
//
//  Created by Igor Guzei on 20.12.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    let vcHabits = HabitsViewController()
    let vcInfo = InfoViewController()
    let vcNew = HabitViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = BackgroundColors.tabBar
        tabBar.tintColor = AppColors.purple

        let ncHabits: UINavigationController = {
            $0.setViewControllers([vcHabits], animated: true)
            $0.tabBarItem = UITabBarItem(title: "Habits", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
            return $0
        }(UINavigationController())

        let ncInfo: UINavigationController = {
            $0.setViewControllers([vcInfo], animated: true)
            $0.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle.fill"), tag: 0)
            return $0
        }(UINavigationController())

        let ncNew: UINavigationController = {
            $0.setViewControllers([vcNew], animated: true)
            $0.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "plus.circle.fill"), tag: 0)
            return $0
        }(UINavigationController())

        viewControllers = [ncHabits, ncInfo, ncNew]
        selectedIndex = 0
    }
}
