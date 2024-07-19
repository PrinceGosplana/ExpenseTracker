//
//  DateFilterView.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 19.07.2024.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date

    /// Whenever the submit button is clicked, this will return the updated start and end dates, and whenever the close button is clicked, the pupup will simple get closed
    var onSubmit: (Date, Date) -> ()
    var onClose: () -> ()

    var body: some View {
        VStack(spacing: 15) {
            DatePicker("Start Date", selection: $start, displayedComponents: [.date])

            DatePicker("End Date", selection: $end, displayedComponents: [.date])

            HStack(spacing: 15) {
                Button("Cancel") {
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.red)

                Button("Filter") {
                    onSubmit(start, end)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.accent)
            }
            .padding(.top, 10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}
