//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 20.12.2022.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource {

    private lazy var label: UILabel = {
        $0.font = Fonts.headline
        $0.text = infoLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var table: UITableView = {
        $0.backgroundColor = AppColors.lightGray
        $0.tableHeaderView = label
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.lightGray
        view.addSubview(table)
        title = "Информация"

        NSLayoutConstraint.activate([

            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            label.topAnchor.constraint(equalTo: table.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: table.leadingAnchor, constant: 18),

        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = infoText
        cell.isSelected = false
        cell.selectionStyle = .none
        cell.contentConfiguration = content

        return cell
    }
}
