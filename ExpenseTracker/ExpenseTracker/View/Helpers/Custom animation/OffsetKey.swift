//
//  OffsetKey.swift
//  CoffeTime
//
//  Created by Oleksandr Isaiev on 06.07.2024.
//

import SwiftUI

/// create a preference key for reading the scoll offset. Will use this offset to hide and unhide the background swipe action view based on the scroll offset. If the offset is not equal to zero, which means the view is swiped, and thus the swipe action view will be visible, otherwise it will be hidden.
struct OffsetKeyCGRect: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct OffsetKeyCGFloat: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
