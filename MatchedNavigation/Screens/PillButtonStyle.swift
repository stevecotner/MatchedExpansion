//
//  PillButtonStyle.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(18)
            .background(
                Capsule()
                    .fill(Color.black)
            )
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .animation(.easeOut, value: configuration.isPressed)
            .padding(.horizontal, 20)
    }
}
