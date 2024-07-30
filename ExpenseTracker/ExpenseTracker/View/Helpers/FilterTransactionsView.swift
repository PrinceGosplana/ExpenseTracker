//
//  FilterTransactionsView.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 26.07.2024.
//

import SwiftData
import SwiftUI

struct FilterTransactionsView<Content: View>: View {

    var content: ([Transaction]) -> Content
    @Query(animation: .snappy) private var transactions: [Transaction]

    init(category: Category?, searchText: String, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
        /// custom predicate

        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Transaction> { transaction in
            (transaction.title.localizedStandardContains(searchText) || transaction.remarks.localizedStandardContains(searchText)) && (rawValue.isEmpty ? true : transaction.category == rawValue)
        }

        _transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)

        self.content = content
    }

    init(startDate: Date, endDate: Date, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
        /// custom predicate

        let predicate = #Predicate<Transaction> { transaction in
            transaction.dateAdded >= startDate && transaction.dateAdded <= endDate
        }

        _transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)

        self.content = content
    }


    init(startDate: Date, endDate: Date, category: Category?, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
        /// custom predicate

        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Transaction> { transaction in
            transaction.dateAdded >= startDate && transaction.dateAdded <= endDate && (rawValue.isEmpty ? true : transaction.category == rawValue)
        }

        _transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)

        self.content = content
    }

    var body: some View {
        content(transactions)
    }
}

