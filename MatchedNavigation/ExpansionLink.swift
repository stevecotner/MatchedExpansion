//
//  ExpansionLink.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct ExpansionLink<Content>: View where Content: View {
    let viewMakerID: String
    let transitionWrapperID: String
    
    @Binding var isActive: Bool
    var transition: ExpansionTransition
    let showsX = true
    
    @EnvironmentObject var expander: Expander
    
    // The view we will "expand" to.
    var destination: () -> Content
    
    var body: some View {
        Rectangle()
            .frame(width: 0.001, height: 0.001)
            .background(Color.black.opacity(0.001))
            .onChange(of: $isActive.wrappedValue) { active in
                if isActive {
                    let viewMaker = ExpansionLinkViewMaker(
                        id: viewMakerID,
                        transitionWrapperID: transitionWrapperID,
                        showsX: showsX,
                        transition: transition,
                        resetActive: { isActive = false },
                        content: destination
                    )
                    
                    expander.add?(viewMaker.typeErasedViewMaker)
                } else {
                    expander.remove?(viewMakerID)
                }
            }
    }
}

enum ExpansionTransition {
    case fade
    case split
    
    var isSplit: Bool {
        switch self {
        case .split:
            return true
            
        default:
            return false
        }
    }
}

struct ExpansionLink_Previews: PreviewProvider {
    static var previews: some View {
        ExpansionLink(
            viewMakerID: "example",
            transitionWrapperID: "example",
            isActive: .constant(true),
            transition: .split,
            destination: {
                Text("Expanded Text")
            }
        )
    }
}
