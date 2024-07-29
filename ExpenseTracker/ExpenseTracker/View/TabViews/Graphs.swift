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
        NavigationStack {
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
                createChartGroup()
            }
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

    private func createChartGroup() {
        Task.detached(priority: .high) {
            let calendar = Calendar.current

            let groupByDate = Dictionary(grouping: transactions) { transaction in
                let components = calendar.dateComponents([.month, .year], from: transaction.dateAdded)

                return components
            }

            /// Sorting groups by date
            let sortedGroups = groupByDate.sorted {
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()

                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }

            let chartGroups = sortedGroups.compactMap { dict -> ChartGroup in
                let date = calendar.date(from: dict.key) ?? .init()
                let income = dict.value.filter({ $0.category == Category.income.rawValue })
                let expense = dict.value.filter({ $0.category == Category.expense.rawValue })

                let incomeTotalValue = total(income, category: .income)
                let expenseTotalValue = total(expense, category: .expense)

                return .init(
                    date: date,
                    categories: [
                        .init(totalValue: incomeTotalValue, category: .income),
                        .init(totalValue: expenseTotalValue, category: .expense)
                    ],
                    totalIncome: incomeTotalValue,
                    totalExpense: expenseTotalValue
                )
            }

            /// UI must be updated on Main thread
            await MainActor.run {
                self.chartGroups = chartGroups
            }
        }
    }
}

#Preview {
    Graphs()
}
