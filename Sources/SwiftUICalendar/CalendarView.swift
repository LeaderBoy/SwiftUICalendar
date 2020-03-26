//
//  CalendarView.swift
//  CalendarView
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

@available(iOS 13.0,*)
public struct CalendarView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            CalendarToolBar()
            CalendarWeekBar()
            CalendarDateCollectionView()
        }.padding()
    }
}

@available(iOS 13.0,*)
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarManager())
    }
}
