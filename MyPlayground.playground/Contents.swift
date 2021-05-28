import UIKit

var greeting = "Hello, playground"


// func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool

let array = [2, 5, 6, 7, 19, 40]

let hasAMultipleOf7 = array.contains { (element) -> Bool in
    element % 7 == 0
}

//print(array, hasAMultipleOf7)

let predicate8 = { (element) -> Bool in element % 8 == 0 }

let hasAMultipleOf8 = array.contains(where: predicate8)
//print(array, hasAMultipleOf8)

// filter out from the first the elements that are also in the second


let first = [1,2,3,4,5,6,7,8]
let second = [1,3,5,7,9]

var result = first.filter{ second.contains($0) }
print(first)
print(second)
print(1, result)

//let predicate = { (element) -> Bool in element % 3 == 0 }
let predicate = { (element) -> Bool in element == 5 }
var resultBool = second.contains(where: predicate)
print(2, resultBool)

//let predicate2 = { (element) -> Bool in element == other }


//----------------------------------------

/*
public extension Array where Element: Equatable {
    /// Return array containing elements of self that are also in other, plus elements from other that are not in self
    /// - Parameter other: the array to update from
    func updatedPreservingOrder(from other: Array) -> [Element] {
        var updated: [Element] = filter { other.contains($0) }
        updated += other.filter { !self.contains($0) }
        return updated
    }

    func updatedPreservingOrder2(from other: Array) -> [Element] {
        var updated: [Element] = filter { other.contains{ } }
        //updated += other.filter { !self.contains($0) }
        return updated
    }
}
*/

struct CalendarData: Codable, Equatable {
    let title: String
    var hidden: Bool = false

    var string: String {
        let hivi = hidden ? "hidden" : "visible"
        return "\(title) \(hivi)"
    }
}

extension CalendarData {
    static func == (lhs: CalendarData, rhs: CalendarData) -> Bool {
        return lhs.title == rhs.title && lhs.hidden == rhs.hidden
    }
}





    struct MockCalendar {
        let title: String
        let otherData = Date()
    }

    var calendarDataArray = [CalendarData(title: "Alice", hidden: false),
                             CalendarData(title: "Bobby", hidden: true),
                             CalendarData(title: "Charlie", hidden: false),
                             CalendarData(title: "Debbie", hidden: true)]

//    printClassAndFunc(info: "original calendarDataArray= \(calendarDataArray.map { $0.string })")

    let incomingCalendars = [MockCalendar(title: "Newbie"),
                             MockCalendar(title: "Oldie"),
                             MockCalendar(title: "Pretty"),
                             MockCalendar(title: "Charlie"),
                             MockCalendar(title: "Bobby")
                             ]

    let incomingCalendarDataArray =  incomingCalendars.map{ CalendarData(title: $0.title) }

//    print("calendarDataArray= \(calendarDataArray.map { $0.string })")
//
//    // emulate the operation in SharedUserDefaults.updateCalendarsAndSelection
//    calendarDataArray = calendarDataArray.updatedPreservingOrder2(from: incomingCalendars.map { CalendarData(title: $0.title) })
//
//    print("updated calendarDataArray= \(calendarDataArray.map { $0.string })")


var filtered: [CalendarData] = []
for cal1 in calendarDataArray {
    for cal2 in incomingCalendarDataArray {
        if cal1.title == cal2.title {
            filtered.append(cal1)
        }
    }
}
print(10, filtered.map{$0.string})

func filterCals(cals1: [CalendarData], cals2: [CalendarData]) -> [CalendarData] {
    var filtered: [CalendarData] = []
    for cal1 in calendarDataArray {
        for cal2 in cals2 {
            if cal1.title == cal2.title {
                filtered.append(cal1)
            }
        }
    }
    return filtered
}
let filtered11 = filterCals(cals1: calendarDataArray, cals2: incomingCalendarDataArray)
print(11, filtered11.map{$0.string})

func findMatch(cal1: CalendarData, incoming: [CalendarData])  -> Bool {
    for cal2 in incoming {
        if cal1.title == cal2.title {
            return true
        }
    }
    return false
}

func filterCals22(cals1: [CalendarData], incoming: [CalendarData]) -> [CalendarData] {
    var filtered: [CalendarData] = []
    for cal1 in cals1 {
        if findMatch(cal1: cal1, incoming: incoming) {
            filtered.append(cal1)
        }
    }
    return filtered
}

let filtered22 = filterCals22(cals1: calendarDataArray, incoming: incomingCalendarDataArray)
print(22, filtered22.map{$0.string})


func filterCals33(cals1: [CalendarData], incoming: [CalendarData]) -> [CalendarData] {
    return cals1.filter{ findMatch(cal1: $0, incoming: incoming) }
}
let filtered33 = filterCals33(cals1: calendarDataArray, incoming: incomingCalendarDataArray)
print(33, filtered33.map{$0.string})


// this works
let filtered44 = calendarDataArray.filter{(elt1) in incomingCalendarDataArray.contains { (elt2) -> Bool in elt1.title == elt2.title} }
print(44, filtered44.map{$0.string})


public extension Array where Element: Equatable {
    /// Return array containing elements of self that are also in other, plus elements from other that are not in self
    /// - Parameter other: the array to update from
    func updatedPreservingOrder(from other: Array) -> [Element] {
        var updated: [Element] = filter { other.contains($0) }
        updated += other.filter { !self.contains($0) }
        return updated
    }

    func updatedPreservingOrder(from other: Array, predicate: (Element, Element) -> Bool) -> [Element] {
        var updated: [Element] = filter { elt1 in other.contains{ (elt2) -> Bool in predicate(elt1, elt2)} }
        updated += other.filter { elt1 in !self.contains{ (elt2) -> Bool in predicate(elt1, elt2)} }
        return updated
    }
}



func sameTitle(elt1: CalendarData, elt2: CalendarData) -> Bool {
    return elt1.title == elt2.title
}

let resultCalendarDataArray55 = calendarDataArray.updatedPreservingOrder(from: incomingCalendarDataArray, predicate: sameTitle)
print(55)
print(55, "resultCalendarDataArray55=", resultCalendarDataArray55.map{$0.string})

let resultCalendarDataArray66 = calendarDataArray.updatedPreservingOrder(from: incomingCalendarDataArray, predicate: { (elt1, elt2) -> Bool in elt1.title == elt2.title })

print(66)
print(66, "calendarDataArray=", calendarDataArray.map{$0.string})
print(66, "incomingCalendarDataArray=", incomingCalendarDataArray.map{$0.string})
print(66, "resultCalendarDataArray66=", resultCalendarDataArray66.map{$0.string})


// OK, it WORKS
