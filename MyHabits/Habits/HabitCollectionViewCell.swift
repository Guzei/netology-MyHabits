//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Igor Guzei on 24.12.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    var cellIndex = 0

    private lazy var habitName: UILabel = {
        $0.textColor = AppColors.blue
        $0.font = Fonts.headline
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var dateString: UILabel = {
        $0.textColor = .systemGray2
        $0.font = Fonts.caption
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var counter: UILabel = {
        $0.textColor = .systemGray2
        $0.font = Fonts.footnoteCaps
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var checkButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super .init(frame: .zero)
        contentView.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    func addSubviews(){
        contentView.layer.cornerRadius = 8
        contentView.addSubview(checkButton)
        contentView.addSubview(habitName)
        contentView.addSubview(dateString)
        contentView.addSubview(counter)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([

            habitName.topAnchor.constraint(equalTo: topAnchor, constant: pagePadding),
            habitName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: pagePadding),
            habitName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -pagePadding * 2 - colorDiskSize),

            dateString.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 8),
            dateString.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),

            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -pagePadding),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            counter.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -pagePadding),

        ])
    }

    func setData(_ index: Int) {
        cellIndex = index
        let habit = store.habits[index]
        habitName.text = habit.name
        dateString.text = habit.dateString
        counter.text = String(habit.trackDates.count)
        checkButton.tintColor = habit.color
        checkButton.setImage(checkImg[habit.isAlreadyTakenToday], for: .normal)
        /// странно работает. checkButton бывает активна даже при false и не заходе в условие.
        //  print(habit.isAlreadyTakenToday)
        if habit.isAlreadyTakenToday == false {
            checkButton.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        }
    }

    @objc func checkHabit() {
        if store.habits[cellIndex].isAlreadyTakenToday == false {
            store.track(store.habits[cellIndex])
            (superview as? UICollectionView)?.reloadItems(at: [IndexPath(row:         0, section: 0),
                                                               IndexPath(row: cellIndex, section: 1) ])
        }
    }
}
