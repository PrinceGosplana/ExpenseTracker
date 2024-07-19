//
//  CustomTransition.swift
//  CoffeTime
//
//  Created by Oleksandr Isaiev on 06.07.2024.
//

import SwiftUI

/// a custom transition that will smoothly move to the top when it's removed
struct CustomTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .mask {
                GeometryReader {
                    let size = $0.size

                    Rectangle()
                        .offset(y: phase == .identity ? 0 : -size.height)
                }
                .containerRelativeFrame(.horizontal)
            }
    }
}
