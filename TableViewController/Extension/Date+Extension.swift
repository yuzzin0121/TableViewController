//
//  Date+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/16/24.
//

import Foundation

extension Date {
    static func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        let string = formatter.string(from: date)
        return string
    }
    
    static func getNextDate(current: Date) -> Date {
        let calendar = Calendar.current
        guard let formatdate = calendar.date(from: DateComponents(year: calendar.component(.year, from: current), month: calendar.component(.month, from: current), day: calendar.component(.day, from: current))) else {
            return current
        }
        
        let plusDate: Date = calendar.date(byAdding: .day, value: 1, to: formatdate) ?? current
        print(formatdate)
        return formatdate
    }
    
    static func isSameDate(self: Date, as date: Date) -> Bool {
        let calendar = Calendar.current
        let isSame = calendar.isDate(self, inSameDayAs: date)
        
        return isSame
    }
}

extension String {
    static func stringToDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        let date = formatter.date(from: date) ?? Date()
        
        return date
    }
}
