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
    let searchPublisher = PassthroughSubject<String, Never>()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {

                }
            }
            .overlay {
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filteredText.isEmpty ? 1 : 0)
            }
            .onChange(of: searchText, { oldValue, newValue in
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filteredText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    Search()
}
