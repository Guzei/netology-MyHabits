//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Igor Guzei on 23.12.2022.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {

    private lazy var lablel: UILabel = {
        $0.textColor = .systemGray
        $0.font = Fonts.footnote
        $0.text = "Всё получится!"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var procent: UILabel = {
        $0.textColor = .systemGray
        $0.font = Fonts.footnote
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var progressBar: UIProgressView = {
        $0.backgroundColor = AppColors.lightGray
        $0.progressTintColor = AppColors.purple
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIProgressView())

    override init(frame: CGRect) {
//        print(#file, #function)
//        print(frame)
        super .init(frame: .zero)

        contentView.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    func addSubviews(){
//        print(#file, #function)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(lablel)
        contentView.addSubview(procent)
        contentView.addSubview(progressBar)
    }

    func setConstraints() {
//        print(#file, #function)
        NSLayoutConstraint.activate([

            lablel.topAnchor.constraint(equalTo: topAnchor, constant: pagePadding),
            lablel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: pagePadding),

            procent.topAnchor.constraint(equalTo: lablel.topAnchor),
            procent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -pagePadding),

            progressBar.heightAnchor.constraint(equalToConstant: 8),
            progressBar.topAnchor.constraint(equalTo: lablel.bottomAnchor, constant: pagePadding),
            progressBar.leadingAnchor.constraint(equalTo: lablel.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: procent.trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -pagePadding),

        ])
    }

    func setData() {
//        print(#file, #function)
        procent.text = String(format: "%.0f%%", store.todayProgress * 100)
        progressBar.progress = store.todayProgress
    }
}
