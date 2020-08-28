//
//  ViewController.swift
//  RudifaUtilPkgDemo
//
//  Created by Rudolf Farkas on 25.08.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

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

    override func viewDidLoad() {
        super.viewDidLoad()

        demo_CollectionUtil()
        demo_DateUtil()
        demo_DebugUtil()
        demo_EnumUtil()
        demo_RegexUtil()
        demo_StringUtil()
        demo_UserDefaultsExt()
    }

    func demo_CollectionUtil() {
        do {
            let arr1 = [5, 4, 3, 2, 1]
            let arr2 = [3, 4, 5, 6, 7]
            let updated = arr1.updatedPreservingOrder(from: arr2)
            printClassAndFunc(info: "arr1= \(arr1) arr2= \(arr2) arr1.updatedPreservingOrder(from: arr2)= \(updated) ")
        }
        do {
            let arr1 = ["5", "4", "3", "2", "1"]
            let arr2 = ["3", "4", "5", "6", "7"]
            let updated = arr1.updatedPreservingOrder(from: arr2)
            printClassAndFunc(info: "arr1= \(arr1) arr2= \(arr2) arr1.updatedPreservingOrder(from: arr2)= \(updated) ")
        }
    }

    func demo_DateUtil() {
        printClassAndFunc(info: "ymDay= \(ymDay.ddMMyyyy_HHmmss)")
        printClassAndFunc(info: "ymMonth= \(ymMonth.ddMMyyyy_HHmmss)")
    }

    func demo_DebugUtil() {
        printClassAndFunc()
        printClassAndFunc(info: "@")
        printClassAndFunc(info: "@here and now")
        logClassAndFunc()
    }

    func demo_EnumUtil() {
        enum Windrose: CaseIterable, Equatable {
            case north, east, south, west
        }

        let dir1 = Windrose.south
        printClassAndFunc(info: "dir1= \(dir1) dir1.next= \(dir1.next) dir1.prev= \(dir1.prev)")

        var dir2 = Windrose.south
        let dir2orig = dir2
        dir2.increment(next: true)
        let dir2next = dir2
        dir2.increment(next: false)
        dir2.increment(next: false)
        let dir2prev = dir2
        printClassAndFunc(info: "dir2orig= \(dir2orig) dir2next= \(dir2next) dir2prev= \(dir2prev)")

        var dir3 = Windrose.south
        let dir3next = dir3.incremented(next: true)
        let dir3orig = dir3.incremented(next: false)
        let dir3prev = dir3.incremented(next: false)
        printClassAndFunc(info: "dir3orig= \(dir3orig) dir3next= \(dir3next) dir3prev= \(dir3prev)")
    }

    func demo_RegexUtil() {
        let str = "abra cadabra"
        let pattern = "a."
        let matches = str.matches(for: pattern)
        printClassAndFunc(info: "str= \"\(str)\" pattern= \"\(pattern)\" matches= \(matches)")
    }

    func demo_StringUtil() {
        let str = "camelCaseSplit"
        printClassAndFunc(info: "str= \"\(str)\" str.camelCaseSplit= \"\(str.camelCaseSplit)\"")
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
        printClassAndFunc(info: "userId= \(LocalCodableDefaults.userId)")
        printClassAndFunc(info: "subscriptionInfo= \(LocalCodableDefaults.subscriptionInfo)")
        printClassAndFunc(info: "titles= \(LocalCodableDefaults.titles)")
    }
}
