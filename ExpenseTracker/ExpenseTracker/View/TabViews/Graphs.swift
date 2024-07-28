//
//  Graphs.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 18.07.2024.
//

import Charts
import SwiftData
import SwiftUI

struct Graphs: View {

    @Query(animation: .snappy) private var transactions: [Transaction]
    @State private var chartGroups: [ChartGroup] = []

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                /// Chart view
                ChartView()
                    .padding(10)
                    .frame(height: 200)
                    .background(.background, in: .rect(cornerRadius: 10))
            }
        }
        .onAppear {
            
        }
    }

    @ViewBuilder
    func ChartView() -> some View {
        Chart {
            ForEach(chartGroups) { group in
                ForEach(group.categories) { chart in
                    BarMark(
                        x: .value("Month", format(date: group.date, format: "MMM yy")),
                        y: .value(chart.category.rawValue, chart.totalValue),
                        width: 20
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        /// Making Chart scrollable
        .chartScrollableAxes(.horizontal)
        /// Foreground colors
        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient])
    }
}

#Preview {
    Graphs()
}
