//
//  ListOfExpenses.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 30.07.2024.
//

import SwiftUI

/// List of transactions for the selected month
struct ListOfExpenses: View {
    let month: Date

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {

                Section {
                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .income) { transactions in
                            ForEach(transactions) { transaction in
                                NavigationLink(value: transaction) {
                                    TransactionCardView(transaction: transaction)
                                }
                            }
                        }
                } header: {
                    Text("Income")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }

                Section {
                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expense) { transactions in
                            ForEach(transactions) { transaction in
                                NavigationLink(value: transaction) {
                                    TransactionCardView(transaction: transaction)
                                }
                            }
                        }
                } header: {
                    Text("Expense")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
            }
            .padding(15)
        }
        .background(.gray.opacity(0.15))
        .navigationTitle(format(date: month, format: "MMM yy"))
        .navigationDestination(for: Transaction.self) { transaction in
            TransactionView(editTransaction: transaction)
        }
    }
}
