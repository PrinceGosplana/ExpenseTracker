//
//  Search.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 18.07.2024.
//

import Combine
import SwiftUI

struct Search: View {

    @State private var searchText = ""
    @State private var filteredText = ""
    @State private var selectedCategory: Category? = nil
    let searchPublisher = PassthroughSubject<String, Never>()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    FilterTransactionsView(category: selectedCategory, searchText: filteredText) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction, showsCategory: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(15)
            }
            .overlay {
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filteredText.isEmpty ? 1 : 0)
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filteredText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filteredText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
            }
        }
    }

    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
                Button {
                    selectedCategory = nil
                } label: {
                    HStack {
                        Text("Both")

                        if selectedCategory == nil {
                            Image(systemName: "checkmark")
                        }
                    }
            }

            ForEach(Category.allCases, id:\.rawValue) { category in
                Button {
                    selectedCategory = category
                } label: {
                    HStack {
                        Text(category.rawValue)

                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "slider.vertical.3")
        }
    }
}

#Preview {
    Search()
}
