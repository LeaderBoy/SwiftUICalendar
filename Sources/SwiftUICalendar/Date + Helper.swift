//
//  Date + Helper.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation


extension Date {
    
    public func isToday() -> Bool {
        return isSameDay(date: Date())
    }
    
    public func isFuture() -> Bool {
        return self > Date()
    }
    
    public func isSameDay(date:Date,in calendar : Calendar = .current) -> Bool {
        return calendar.isDate(date, inSameDayAs: self)
    }
    
    public func addDay(by : Int ,in calendar : Calendar = .current) -> Date {
        return calendar.date(byAdding: .day, value: by, to: self)!
    }
    
    public func addMonth(by : Int ,in calendar : Calendar = .current) -> Date {
        return calendar.date(byAdding: .month, value: by, to: self)!
    }
    
    public func dayDiff(in calendar : Calendar = .current,to:Date) -> Int {
        return calendar.dateComponents([.day], from: self, to: to).day!
    }
    
    public func monthDiff(in calendar : Calendar = .current,to:Date) -> Int {
        return calendar.dateComponents([.month], from: self, to: to).month!
    }
    
    public func numberOfDays(in calendar : Calendar = .current) -> Int {
        return calendar.range(of: .day, in: .month, for: self)!.count
    }
    
    public func allDays(in calendar : Calendar = .current) -> [Date] {
        var dateComponents = DateComponents()
        var dates : [Date] = []
        for index in 0..<numberOfDays(in: calendar) {
            dateComponents.setValue(index, for: .day)
            let date = calendar.date(byAdding: dateComponents, to: firstDay()!)!
            dates.append(date)
        }
        return dates
    }
    
    public func date(at index : Int) -> Date {
        let days = allDays()
        if days.count > index {
            return days[index]
        }
        assert(false ,"index out of bounds")
    }
    
    public func firstDay(in calendar : Calendar = .current) -> Date? {
        if let interval = calendar.dateInterval(of: .month, for: self) {
            return interval.start
        }
        return nil
    }
    
    public func firstDayOfWeek(in calendar : Calendar = .current) -> Int {
        let first = firstDay(in: calendar)!
        let components = calendar.dateComponents([.weekday], from: first)
        return components.weekday!
    }
    
    public func lastDay(in calendar : Calendar = .current) -> Date? {
        if let interval = calendar.dateInterval(of: .month, for: self) {
            return interval.end
        }
        return nil
    }
    
    public func dateComponents(in calendar : Calendar = .current) -> DateComponents {
        let components = calendar.dateComponents([.year,.month,.day], from: self)
        return components
    }
}
