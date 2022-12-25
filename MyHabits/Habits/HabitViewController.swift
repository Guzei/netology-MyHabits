//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 21.12.2022.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    let newHabit = Habit(name: "", date: Date(), color: .systemRed)

    private lazy var habitNameLabel: UILabel = {
        $0.text = "НАЗВАНИЕ"
        $0.font = Fonts.footnoteStatus
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var habitNameText: UITextField = {
        $0.addTarget(self, action: #selector(setName), for: .editingChanged)
        $0.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        $0.clearButtonMode = .whileEditing
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
        $0.tintColor = newHabit.color
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
        $0.text = newHabit.timeString
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
//        print(#function, #file)
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Создать"

        navigationController?.navigationBar.tintColor = AppColors.purple

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))

        habitNameText.text = newHabit.name

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
        newHabit.name = textField.text ?? ""
    }

    @objc func setColor() {
        print(#file, #function)
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        picker.modalTransitionStyle = .crossDissolve
        self.present(picker, animated: true, completion: nil)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        print(#file, #function)
        newHabit.color = color
        colorButton.tintColor = newHabit.color
    }

    @objc func setDate(_ datePiker: UIDatePicker){
        print(#file, #function)
        newHabit.date = datePiker.date
        time.text = newHabit.timeString
    }

    @objc private func cancel() {
        print(#file, #function)
        dismiss(animated: true)
    }

    @objc func save() {
        print(#file, #function)
        if newHabit.name != "" {
            store.habits.append(newHabit)
        }

        dismiss(animated: true)
    }
}
