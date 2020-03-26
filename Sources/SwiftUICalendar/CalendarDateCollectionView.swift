//
//  CalendarDateCollectionView.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI
import SwiftUIViewPager

@available(iOS 13.0,*)
public struct CalendarDateCollectionView: View {
    
    @EnvironmentObject var manager : CalendarManager
    @State private var state : CalendarCell.CellState = .normal
    @State private var size : CGSize = .zero
    
    public init() {}
    
    public var body: some View {
        ViewPager(pageManager: self.manager.pageManager, views:[self.page()])
        .frame(height: 44 * 6)
    }

    func page() -> some View {
        VStack {
            VStack {
                ForEach(self.datesArray(),id: \.self) { rows in
                    HStack(spacing:0) {
                        ForEach(rows,id: \.self) { column in
                            HStack {
                                Spacer(minLength: 0)
                                
                                CalendarCell(holderDate: column)
                                    /// Don't know why
                                    /// CalendarView in ScrollView will crash some times because of CalendarCell manager is nil
                                    /// so to prevent the crash
                                    .environmentObject(self.manager)
                                Spacer(minLength: 0)
                            }
                        }
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    /// Combine row and column for collectionView
    func datesArray() -> [[HolderDate]] {
        var rowArray : [[HolderDate]] = []
        let columns = numberOfColumns()
        let rows = numberOfRows()
        let days = self.manager.date.allDays()
        let placeholder = HolderDate(date: nil)
        let offset = dayOffset()
        
        for row in 0..<rows {
            var columnArray : [HolderDate] = []
            for column in 0..<columns {
                let index = row * columns + column
                if index < offset || days.count <= (index - offset) {
                    columnArray.append(placeholder)
                } else {
                    let d = days[index - offset]
                    columnArray.append(HolderDate(date: d))
                }
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    /// Rows in specified month
    func numberOfRows() -> Int {
        let actualDays = manager.date.numberOfDays()
        let offset = dayOffset()
        let days = actualDays + offset
        let columns = numberOfColumns()
        let number = days % columns
        if number == 0 {
            return days / columns
        } else {
            return days / columns + 1
        }
    }
    /// Column in specified month
    func numberOfColumns() -> Int {
        return 7
    }
    
    func dayOffset() -> Int {
        return manager.date.firstDayOfWeek() - 1
    }
}

public struct HolderDate : Hashable {
    let date : Date?
    
    public init(date : Date?) {
        self.date = date
    }
}

@available(iOS 13.0,*)
struct CalendarDateCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarDateCollectionView()
//            .previewLayout(.fixed(width: 400, height: 300))
            .environmentObject(CalendarManager())
//
//            CalendarDateCollectionView()
//            .previewLayout(.fixed(width: 320, height: 300))
//            .environmentObject(CalendarManager())
        }
    }
}
