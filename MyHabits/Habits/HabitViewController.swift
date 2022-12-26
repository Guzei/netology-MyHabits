//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 21.12.2022.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    var popToRootDelegate: PopToRoot?

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

    private lazy var delButton: UIButton = {
        $0.setTitle("Удалить привычку", for: .normal)
        $0.backgroundColor = .systemGray5
        $0.setTitleColor(.systemRed, for: .normal)
        $0.titleLabel?.font = Fonts.body
        $0.isHidden = true
        $0.addTarget(self, action: #selector(delHabit), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        print(#fileID, #function, "habitIndex:", habitIndex ?? "nil")
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
            delButton.isHidden = false
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
        view.addSubview(delButton)
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

            delButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            delButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            delButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),

        ])
    }

    @objc private func setName(_ textField: UITextField) {
        habit.name = textField.text ?? ""
    }

    @objc func setColor() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        picker.modalTransitionStyle = .crossDissolve
        self.present(picker, animated: true)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        habit.color = color
        colorButton.tintColor = habit.color
    }

    @objc func setDate(_ datePiker: UIDatePicker){
        habit.date = datePiker.date
        tempDate = datePiker.date
        time.text = habit.timeString
    }

    @objc private func save() {
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
        habit.name = tempName
        habit.color = tempColor
        habit.date = tempDate
        dismiss(animated: true)
    }

    @objc private func delHabit() {

        let alert = UIAlertController(title: "Удалить привычку",  message: "Вы хотите удалить привычку \"\(habit.name)\"?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive   ) { _ in
            store.habits.remove(at: self.habitIndex!)
            self.popToRootDelegate?.popToRoot()
            self.dismiss(animated: true)
        })

        present(alert, animated: true)
    }
}
