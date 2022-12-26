//
//  ViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 19.12.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var title3: UILabel = {
        $0.font = Fonts.title3
        $0.text = "Сегодня"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier.0)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier.1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        habitsCollectionView.reloadData()
        view.backgroundColor = AppColors.lightGray
        navigationController?.navigationBar.tintColor = AppColors.purple
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))

        addSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Нужен флаг новое/исправленное, если есть желание избежать лишних обновления. Или в игнор.
        habitsCollectionView.reloadData()
    }

    func addSubviews() {
        view.addSubview(title3)
        view.addSubview(habitsCollectionView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([

            title3.heightAnchor.constraint(equalToConstant: Fonts.title3.pointSize * 2),
            title3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            title3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pagePadding),

            habitsCollectionView.topAnchor.constraint(equalTo: title3.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    @objc func addHabit() {
        let nc = UINavigationController(rootViewController: HabitViewController())
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .flipHorizontal
        navigationController?.present(nc, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : store.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: habitsCollectionView.bounds.width - pagePadding * 2,
               height: indexPath.section == 0 ? pagePadding * 4 + 8 : 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: pagePadding, left: pagePadding, bottom: 0, right: pagePadding)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.0, for: indexPath) as! ProgressCollectionViewCell
            cell.setData()
            return cell
        } else {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.1, for: indexPath) as! HabitCollectionViewCell
            cell.setData(indexPath.row)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let vc = HabitDetailsViewController()
            vc.habitIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
