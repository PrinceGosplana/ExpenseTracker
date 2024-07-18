//
//  Recents.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 18.07.2024.
//

import SwiftUI

struct Recents: View {
    var body: some View {
        GeometryReader {
            let size = $0.size

            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {

                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
            }
        }
    }

    /// Header view
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Welcome!")
                .font(.title.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ContentView()
}
