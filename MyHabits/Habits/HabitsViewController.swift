//
//  ViewController.swift
//  MyHabits
//
//  Created by Igor Guzei on 19.12.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var title3: UILabel = {
//        $0.backgroundColor = .systemYellow
        $0.font = Fonts.title3
        $0.text = "Сегодня"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var habitsProgress: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = BackgroundColors.collection
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        print(#file, #function)
        super.viewDidLoad()
        view.backgroundColor = BackgroundColors.mainView
        navigationController?.navigationBar.tintColor = AppColors.purple

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAdd))

        // store.habits = []
        //        print(store.habits.count)
        //        print("first:", store.habits.first?.dateString ?? "no date for first")
        //        print("last:", store.habits.last?.dateString ?? "no date for last")

        addSubviews()
        setConstraints()
    }

    func addSubviews() {
        print(#file, #function)
        view.addSubview(title3)
        view.addSubview(habitsProgress)
    }

    func setConstraints() {
        print(#file, #function)
        NSLayoutConstraint.activate([

            title3.heightAnchor.constraint(equalToConstant: Fonts.title3.pointSize * 2),
            title3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            title3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pagePadding),

            habitsProgress.topAnchor.constraint(equalTo: title3.bottomAnchor),
            habitsProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsProgress.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    @objc func pressAdd() {
        print(#file, #function)
        let nc = UINavigationController(rootViewController: HabitViewController())
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .flipHorizontal
        navigationController?.present(nc, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(#file, #function)
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#file, #function)
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#file, #function)
        // habitsProgress.bounds.width vs. UIScreen.main.bounds.width ?
        return CGSize(width: (habitsProgress.bounds.width - pagePadding * 2), height: pagePadding * 4 + 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print(#file, #function)
        return UIEdgeInsets(top: pagePadding, left: pagePadding, bottom: pagePadding, right: pagePadding)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#file, #function)
        let cell = habitsProgress.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProgressCollectionViewCell
        cell.setData()
        return cell
    }
}

