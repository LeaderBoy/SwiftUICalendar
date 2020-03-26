//
//  CalendarWeekBar.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

@available(iOS 13.0,*)
public struct CalendarWeekBar: View {
    
    @EnvironmentObject var manager : CalendarManager
    
    var color : Color = Color.gray
        
    public var body: some View {
        HStack {
            ForEach(self.weeks(),id:\.self) { week in
                HStack {
                    Spacer()
                    Text(week)
                        .lineLimit(1)
                        .foregroundColor(self.color)
                    Spacer()
                }
            }
        }
    }
    
    func weeks() -> [String] {
        return manager.calendar.shortStandaloneWeekdaySymbols
        //(identifier: "zh_Hans_CN")
//        return ca.shortStandaloneMonthSymbols
    }
}

@available(iOS 13.0,*)
struct CalendarWeekBar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWeekBar().environmentObject(CalendarManager())
    }
}
