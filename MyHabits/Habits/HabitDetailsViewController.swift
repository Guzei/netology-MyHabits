//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 25.12.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController, UITableViewDataSource {

    var cellIndex = 0
    var countOfRows = store.dates.count - 1  // исключаем сегодняшний день

    private lazy var habitsList: UITableView = {
        $0.backgroundColor = .systemGray6
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier.0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())

    override func viewDidLoad() {
        print(#file, #function)
        super.viewDidLoad()
        view.backgroundColor = AppColors.lightGray
        navigationItem.title = store.habits[cellIndex].name

        addSubviews()
        setConstraints()
    }

    func addSubviews() {
        print(#file, #function)
        view.addSubview(habitsList)
    }

    func setConstraints() {
        print(#file, #function)
        NSLayoutConstraint.activate([

            habitsList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        print(#file, #function, indexPath, countOfRows)

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.0, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let indexRevers = countOfRows - 1 - indexPath.row
        content.text = store.trackDateString(forIndex: indexRevers) ?? "no date for index \(indexPath.row)"
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        if store.habit(store.habits[indexRevers], isTrackedIn: store.dates[indexRevers]) {
            cell.accessoryType  = .checkmark
            cell.tintColor = .purple
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
}
