//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Igor Guzei on 24.12.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    private lazy var habitName: UILabel = {
        $0.backgroundColor = .yellow
        $0.textColor = AppColors.blue
        $0.font = Fonts.headline
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var dateString: UILabel = {
        $0.backgroundColor = .yellow
        $0.textColor = .systemGray2
        $0.font = Fonts.caption
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var counter: UILabel = {
        $0.backgroundColor = .yellow
        $0.textColor = .systemGray2
        $0.font = Fonts.footnoteCaps
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var checkButton: UIButton = {
        $0.tintColor = .systemYellow
        $0.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)), for: .normal)
        $0.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    @objc func checkHabit(){
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)), for: .normal)
    }

    override init(frame: CGRect) {
        print(#file, #function)
        print(frame)
        super .init(frame: .zero)

        contentView.backgroundColor = BackgroundColors.cell
        addSubviews()
        setConstraints()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    func addSubviews(){
        print(#file, #function)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(checkButton)
        contentView.addSubview(habitName)
        contentView.addSubview(dateString)
        contentView.addSubview(counter)
    }

    func setConstraints() {
        print(#file, #function)
        NSLayoutConstraint.activate([

            habitName.topAnchor.constraint(equalTo: topAnchor, constant: pagePadding),
            habitName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: pagePadding),
            habitName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -pagePadding * 2 - 32),

            dateString.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 8),
            dateString.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),

            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -pagePadding),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            counter.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -pagePadding),

        ])
    }

    func setData(_ index: Int) {
        print(#file, #function)
        habitName.text = store.habits[index].name
        dateString.text = store.habits[index].dateString
        counter.text = String(store.habits[index].trackDates.count)
        checkButton.tintColor = store.habits[index].color
    }
}
