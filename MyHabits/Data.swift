//
//  Data.swift
//  MyHabits
//
//  Created by Igor Guzei on 19.12.2022.
//

import UIKit

protocol PopToRoot {
    func popToRoot()
}

let detailsFromDay = 1          // 0 - показывать делали с сегодняшнего дня (галочки видны сразу), 1 - с завтрашнего, ...

let store = HabitsStore.shared

let pagePadding = 16.0
let colorDiskSize = 32.0

let cellIdentifier = ("i0", "i1")

let checkImg: Dictionary <Bool, UIImage> = [
    false: UIImage(systemName:           "circle"     , withConfiguration: UIImage.SymbolConfiguration(pointSize: colorDiskSize))!,
    true : UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: colorDiskSize))!
]

enum Fonts {
    static let title3         = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let headline       = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let body           = UIFont.systemFont(ofSize: 17, weight:  .regular)
    static let footnoteCaps   = UIFont.systemFont(ofSize: 13, weight:     .bold)
    static let footnoteStatus = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let footnote       = UIFont.systemFont(ofSize: 13, weight:  .regular)
    static let caption        = UIFont.systemFont(ofSize: 12, weight:  .regular)
}

enum AppColors {
    static let lightGray = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    static let orange    = UIColor(red:       1, green: 159/255, blue:  79/255, alpha: 1)
    static let purple    = UIColor(red: 161/255, green:  22/255, blue: 204/255, alpha: 1)
    static let green     = UIColor(red:  29/255, green: 179/255, blue:  34/255, alpha: 1)
    static let blue      = UIColor(red:  41/255, green: 109/255, blue:       1, alpha: 1)
    static let blue2     = UIColor(red:  98/255, green:  54/255, blue:       1, alpha: 1)
}

let infoLabel = "Привычка за 21 день"

let infoText = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

Источник: psychbook.ru
"""
