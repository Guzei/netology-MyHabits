//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 20.12.2022.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private lazy var table: UITableView = {
        $0.backgroundColor = BackgroundColors.table
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none
        $0.tableHeaderView = label
        $0.sectionHeaderHeight = 0                              // без этого heightForHeaderInSection не работает
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    private lazy var label: UILabel = {
        $0.font = .systemFont(ofSize: FontSize.infoLabel, weight: .semibold)
        $0.text = infoLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackgroundColors.mainView

        title = "Информация"

        view.addSubview(label)
        view.addSubview(table)

        NSLayoutConstraint.activate([

            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            label.topAnchor.constraint(equalTo: table.topAnchor, constant: pagePadding),
            label.leadingAnchor.constraint(equalTo: table.leadingAnchor, constant: pagePadding),
            label.trailingAnchor.constraint(equalTo: table.trailingAnchor),

        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = infoText
        cell.contentConfiguration = content

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        pagePadding * 2 + FontSize.infoLabel
    }
}
