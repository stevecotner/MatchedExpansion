//
//  ExpansionLinkViewMaker.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/16/22.
//

import SwiftUI

struct ExpansionLinkViewMaker<Content> where Content: View {
    var id: String
    var transitionWrapperID: String
    let showsXButton: Bool
    let transition: ExpansionTransition
    var resetActive: () -> Void
    var removeSelfFromViewMakers: (String) -> Void
    var content: (@escaping CollapseAction) -> Content
    var typeErasedViewMaker: TypeErasedExpansionLinkViewMaker {
        let anyfiedContent = {
            AnyView(
                content(
                    {
                        resetActive()
                        removeSelfFromViewMakers(id)
                    }
                )
            )
        }
        
        return TypeErasedExpansionLinkViewMaker(
            id: id,
            transitionWrapperID: transitionWrapperID,
            showsXButton: showsXButton,
            transition: transition,
            resetActive: resetActive,
            content: anyfiedContent
        )
    }
}

struct TypeErasedExpansionLinkViewMaker {
    var id: String
    var transitionWrapperID: String
    let showsXButton: Bool
    let transition: ExpansionTransition
    var resetActive: () -> Void
    var content: () -> AnyView
}
