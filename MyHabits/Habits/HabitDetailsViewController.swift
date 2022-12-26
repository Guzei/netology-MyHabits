//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 25.12.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController, UITableViewDataSource {

    var habitIndex = 0
    var countOfRows = store.dates.count - detailsFromDay  // Если не исключать сегодняшний день, то галочки будут видны сразу

    private lazy var habitsList: UITableView = {
        $0.backgroundColor = .systemGray4
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier.0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = store.habits[habitIndex].name
    }
    
    override func viewDidLoad() {
        print(#fileID, #function, "// habitIndex:", habitIndex)
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        navigationItem.title = store.habits[habitIndex].name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editHabit))

        addSubviews()
        setConstraints()
    }

    func addSubviews() {
        view.addSubview(habitsList)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            habitsList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    @objc func editHabit() {
        let vc = HabitViewController()
        vc.habitIndex = habitIndex
        vc.popToRootDelegate = self
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .flipHorizontal
        navigationController?.present(nc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.0, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let indexRevers = countOfRows - 1 - indexPath.row
        content.text = store.trackDateString(forIndex: indexRevers) ?? "no date for index \(indexPath.row)"
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        if store.habit(store.habits[habitIndex], isTrackedIn: store.dates[indexRevers]) {
            cell.accessoryType  = .checkmark
            cell.tintColor = .purple
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
}

extension HabitDetailsViewController: PopToRoot {
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)  // .popViewController(animated: true)
    }
}
