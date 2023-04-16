//
//  ScheduleView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.01.2023.
//

import SwiftUI

struct ScheduleView: View {
    @State private var currentDay: Date = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            timelineView()
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            headerView()
        }
        
    }
    
    @ViewBuilder
    func headerView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Расписание")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                }
                .HAllignment(.leading)
                
                Button {
                    
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.mint)
                        Text("Добавить осмотр")
                            .foregroundColor(Color.mint)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
//                    .background {
//                        Capsule()
//                            .fill(Color.theme.accent)
//                    }
                }
            }
            Text(Date().toString("MMM YYYY").localizedUppercase)
                .HAllignment(.leading)
                .padding(.top, 2)
            weekRow()
            

        }
        .padding(15)
        .background {
            VStack(spacing: 0) {
                Color.theme.background
                Rectangle()
                    .fill(.linearGradient(colors: [Color.theme.background, .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func timelineView() -> some View {
        VStack {
            let hours = Calendar.current.hours
            ForEach(hours, id: \.self) { hour in
                timelineViewRow(hour)
            }
            .HAllignment(.leading)
            .padding(.vertical, 15)
        }
    }
    
    @ViewBuilder
    func timelineViewRow(_ hour: Date) -> some View {
        HStack(alignment: .top) {
            Text(hour.toString("h a"))
                .font(.subheadline)
                .frame(width: 45, alignment: .leading)
            
            Rectangle()
                .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                .frame(height: 0.5)
                .offset(y: 10)
        }
    }
    
    @ViewBuilder
    func weekRow() -> some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6) {
                    Text(weekDay.string.prefix(3).localizedUppercase)
                        .font(.callout)
                    Text(weekDay.date.toString("d"))
                        .font(.callout)
                }
                .foregroundColor(status ? .mint : .gray)
                .HAllignment(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
                
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

extension View {
    func HAllignment(_ allignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: allignment)
    }
    
    func VAllignment(_ allignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: allignment)
    }
}

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Calendar {
    var hours: [Date] {
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24 {
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay) {
                hours.append(date)
            }
        }
        return hours
    }
    
    var currentWeek: [WeekDay] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        var week: [WeekDay] = []
        for index in 0..<7 {
            if let day = self.date(bySetting: .day, value: index, of: firstWeekDay) {
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
                
        }
        return week
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
