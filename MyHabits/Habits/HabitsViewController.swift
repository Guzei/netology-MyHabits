//
//  ViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 19.12.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        print(#function, #file)
        super.viewDidLoad()
        view.backgroundColor = .systemBrown //BackgroundColors.mainView
        title = "Привычки"
        navigationController?.navigationBar.tintColor = AppColors.purple

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAdd))

        // store.habits = []
        print(store.habits.count)
        print("first:", store.habits.first?.dateString ?? "no date for first")
        print("last:", store.habits.last?.dateString ?? "noe date for last")
    }

    @objc func pressAdd() {
        print(#function)
        let nc = UINavigationController(rootViewController: HabitViewController())
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .flipHorizontal
        navigationController?.present(nc, animated: true, completion: nil)
    }
}

