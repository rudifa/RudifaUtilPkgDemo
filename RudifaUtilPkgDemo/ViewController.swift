//
//  ViewController.swift
//  RudifaUtilPkgDemo
//
//  Created by Rudolf Farkas on 25.08.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import BarChartPkg
import RudifaUtilPkg
import UIKit

class ViewController: UIViewController {
    @WholeDay var ymDay = Date()
    @WholeMonth var ymMonth = Date()

    // A struct that an app wants to save in UserDefaults
    struct SubscriptionInfo: Codable, Equatable {
        let productId: String
        let purchaseDate: Date?
    }

    enum LocalCodableDefaults {
        // define keys to defaults
        enum Key: String {
            case userId
            case subscriptionInfo
            case titles
        }

        @CodableUserDefault(key: Key.userId,
                            defaultValue: "UNKNOWN")
        static var userId: String

        @CodableUserDefault(key: Key.subscriptionInfo,
                            defaultValue: SubscriptionInfo(productId: "ABBA",
                                                           purchaseDate: Date()))
        static var subscriptionInfo: SubscriptionInfo

        @PlistUserDefault(key: Key.titles,
                          defaultValue: [])
        static var titles: [String]
    }

    var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .systemTeal // uncomment for visual debugging
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body) // .systemFont(ofSize: 18)
        label.text = "Month"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        demo_CollectionUtil()
        demo_DateUtil()
        demo_DebugUtil()
        demo_EnumUtil()
        demo_RegexUtil()
        demo_RegexUtil_extractDouble()
        demo_StringUtil()
        demo_UserDefaultsExt()
        demo_TwoYearInterval()

        // RudifaUtilPkgDemo.updatePriceDisplayLabelText()

        view.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 200.0),
            priceLabel.heightAnchor.constraint(equalToConstant: 30.0),
        ])

        updatePriceLabel(priceString: "19.95", currencyShort: "CHF/H")
    }

    func demo_CollectionUtil() {
        do {
            let arr1 = [5, 4, 3, 2, 1]
            let arr2 = [3, 4, 5, 6, 7]
            let updated = arr1.updatedPreservingOrder(from: arr2)
            printClassAndFunc("arr1= \(arr1) arr2= \(arr2) arr1.updatedPreservingOrder(from: arr2)= \(updated) ")
        }
        do {
            let arr1 = ["5", "4", "3", "2", "1"]
            let arr2 = ["3", "4", "5", "6", "7"]
            let updated = arr1.updatedPreservingOrder(from: arr2)
            printClassAndFunc("arr1= \(arr1) arr2= \(arr2) arr1.updatedPreservingOrder(from: arr2)= \(updated) ")
        }
    }

    func demo_DateUtil() {
        printClassAndFunc("ymDay= \(ymDay.ddMMyyyy_HHmmss)")
        printClassAndFunc("ymMonth= \(ymMonth.ddMMyyyy_HHmmss)")
    }

    func demo_DebugUtil() {
        printClassAndFunc("")
        printClassAndFunc("@")
        printClassAndFunc("@here and now")
        logClassAndFunc()
    }

    @available(*, deprecated) // silence warnings
    func demo_EnumUtil() {
        enum Windrose: CaseIterable, Equatable {
            case north, east, south, west
        }

        let dir1 = Windrose.south
        printClassAndFunc("dir1= \(dir1) dir1.next= \(dir1.next) dir1.prev= \(dir1.prev)")

        var dir2 = Windrose.south
        let dir2orig = dir2
        dir2.next(true)
        let dir2next = dir2
        dir2.next(false)
        dir2.next(false)
        let dir2prev = dir2
        printClassAndFunc("dir2orig= \(dir2orig) dir2next= \(dir2next) dir2prev= \(dir2prev)")

        let dir3 = Windrose.south
        let dir3next = dir3.next
        let dir3orig = dir3.prev
        let dir3prev = dir3.prev
        printClassAndFunc("dir3orig= \(dir3orig) dir3next= \(dir3next) dir3prev= \(dir3prev)")
    }

    func demo_RegexUtil() {
        let str = "abra cadabra"
        let pattern = "a."
        let matches = str.matches(for: pattern)
        printClassAndFunc("str= \"\(str)\" pattern= \"\(pattern)\" matches= \(matches)")
    }

    func demo_RegexUtil_extractDouble() {
        let containsANumber = #"{\"USD\":57938.29}"#
        let extracted = containsANumber.extractDouble()!
        printClassAndFunc("containsANumber= \(containsANumber) extracted= \(extracted)")
    }

    func demo_StringUtil() {
        let str = "camelCaseSplit"
        printClassAndFunc("str= \"\(str)\" str.camelCaseSplit= \"\(str.camelCaseSplit)\"")
    }



    struct UsingPropertyWrappers {
        @WholeMonth var yMonth: Date
        @WholeDay var ymDay: Date
        @WholeHours var ymdHours: [Date]

        init(date: Date) {
            yMonth = date
            ymDay = date
            ymdHours = []
        }
    }

    func demo_UserDefaultsExt() {
        printClassAndFunc("userId= \(LocalCodableDefaults.userId)")
        printClassAndFunc("subscriptionInfo= \(LocalCodableDefaults.subscriptionInfo)")
        printClassAndFunc("titles= \(LocalCodableDefaults.titles)")
    }
}

extension ViewController {
    fileprivate func attributedString(_ priceString: String, _ currencyShort: String) -> NSAttributedString {
        return NSAttributedString(stringsWithStyle: [(priceString, .title3), (currencyShort, .footnote)], separator: " ")
    }

    func updatePriceLabel(priceString: String, currencyShort: String) {
        priceLabel.isHidden = (priceString == "0.00")
        priceLabel.attributedText = attributedString(priceString, currencyShort)
    }

    func demo_TwoYearInterval() {
        let date = Date()
        do {
            let intervalTwoYearsAroundToday = DateInterval.twoYearsAround(date: date)
            printClassAndFunc("intervalTwoYearsAroundToday= \(intervalTwoYearsAroundToday)")
        }
        do {
            let intervalTwoYearsAroundToday = date.twoYearsAround
            printClassAndFunc("intervalTwoYearsAroundToday= \(intervalTwoYearsAroundToday)")
        }
    }
}
