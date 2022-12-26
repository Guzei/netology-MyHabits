//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 21.12.2022.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    var habitIndex: Int?
    var habit = Habit(name: "", date: Date(), color: .systemRed)
    var tempName = ""
    var tempColor: UIColor = .systemRed
    var tempDate = Date()

    private lazy var habitNameLabel: UILabel = {
        $0.text = "НАЗВАНИЕ"
        $0.font = Fonts.footnoteStatus
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var habitNameText: UITextField = {
        $0.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        $0.clearButtonMode = .whileEditing
        $0.addTarget(self, action: #selector(setName), for: .editingChanged)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    private lazy var colorLabel: UILabel = {
        $0.text = "ЦВЕТ"
        $0.font = Fonts.footnoteStatus
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var colorButton: UIButton = {
        $0.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: colorDiskSize)), for: .normal)
        $0.addTarget(self, action: #selector(setColor), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    private lazy var dateLabel: UILabel = {
        $0.text = "ВРЕМЯ"
        $0.font = Fonts.footnoteStatus
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var dateSubLabel: UILabel = {
        $0.text = "Каждый день в "
        $0.font = Fonts.body
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var time: UILabel = {
        $0.textColor = AppColors.purple
        $0.font = Fonts.body
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var datePiker: UIDatePicker = {
        $0.addTarget(self, action: #selector(setDate), for: .valueChanged)
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIDatePicker())

    override func viewDidLoad() {
//        print(#file, #function)
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        title = habitIndex == nil ? "Создать" : "Править"

        navigationController?.navigationBar.tintColor = AppColors.purple

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))

        /// запоминаем редактируемые компоненты, чтобы вернуть как было при отмене
        if habitIndex != nil {
            tempName = store.habits[habitIndex!].name
            tempColor = store.habits[habitIndex!].color
            tempDate = store.habits[habitIndex!].date
            habit = store.habits[habitIndex!]
        }

        /// заполняем поля данными
        habitNameText.text = habit.name
        colorButton.tintColor = habit.color
        time.text = habit.timeString

        addSubviews()
        setConstraints()
    }

    func addSubviews() {

        view.addSubview(habitNameLabel)
        view.addSubview(habitNameText)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(dateLabel)
        view.addSubview(dateSubLabel)
        view.addSubview(time)
        view.addSubview(datePiker)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([

            habitNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: pagePadding),
            habitNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pagePadding),

            habitNameText.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 8),
            habitNameText.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),

            colorLabel.topAnchor.constraint(equalTo: habitNameText.bottomAnchor, constant: 32),
            colorLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),

            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 16),
            colorButton.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),

            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 32),
            dateLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),

            dateSubLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            dateSubLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),

            time.leadingAnchor.constraint(equalTo: dateSubLabel.trailingAnchor),
            time.bottomAnchor.constraint(equalTo: dateSubLabel.bottomAnchor),

            datePiker.topAnchor.constraint(equalTo: dateSubLabel.bottomAnchor, constant: 32),
            datePiker.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }

    @objc private func setName(_ textField: UITextField) {
//        print(#file, #function)
        habit.name = textField.text ?? ""
    }

    @objc func setColor() {
//        print(#file, #function)
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        picker.modalTransitionStyle = .crossDissolve
        self.present(picker, animated: true)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
//        print(#file, #function)
        habit.color = color
        colorButton.tintColor = habit.color
    }

    @objc func setDate(_ datePiker: UIDatePicker){
//        print(#file, #function)
        habit.date = datePiker.date
        tempDate = datePiker.date
        time.text = habit.timeString
    }

    @objc func save() {
//        print(#file, #function)
        if habit.name != "" {
            if habitIndex == nil {
                // TODO: добавить защиту от дублей, диагностику ошибок...
                store.habits.append(habit)
            } else {
                store.save()
            }
        }
        dismiss(animated: true)
    }

    @objc private func cancel() {
//        print(#file, #function)
        habit.name = tempName
        habit.color = tempColor
        habit.date = tempDate
        print(habit.name)
        dismiss(animated: true)
    }
}
