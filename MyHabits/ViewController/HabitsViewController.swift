//
//  ViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 19.12.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackgroundColors.mainView
        title = "Привычки"

        let store = HabitsStore.shared
        print(store.habits) // распечатает список добавленных привычек
    }
}

