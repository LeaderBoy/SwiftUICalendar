//
//  CalendarManager.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/26.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIViewPager

@available(iOS 13.0,*)
public class CalendarManager : ObservableObject {
    
    public let didChangeSelectedDate = PassthroughSubject<Date,Never>()
    
    @Published public var calendar : Calendar = .current
    @Published public var selectedDate : Date = Date() {
        didSet {
            didChangeSelectedDate.send(selectedDate)
        }
    }
    @Published public var selectedDates : [Date] = []
    @Published public var pageManager = PageManager(disableReuse: true)
    /// 24 year
    @Published public var minDate = Date().addMonth(by: -12 * 10)
    @Published public var date : Date = Date()
    @Published public var maxDate = Date().addMonth(by: 12 * 10)
    
    public var months : Int {
        return minDate.monthDiff(to: maxDate)
    }

    public var anyCancellable: AnyCancellable? = nil

    /// for nest ObservableObject not work
    ///  https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects
    public init() {
        anyCancellable = pageManager.objectWillChange.sink(receiveValue: { value in
            self.objectWillChange.send()
        })
    }
}
