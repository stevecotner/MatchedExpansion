//
//  Expander.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/16/22.
//

import SwiftUI

class Expander: ObservableObject {
    var namespace: Namespace.ID?
    var totalHeight: CGFloat?
    var viewMakers: [TypeErasedExpansionLinkViewMaker] = []
    
    var activeTransitionWrapperIDs: [String] {
        return viewMakers.compactMap {
            return $0.transitionWrapperID
        }
    }
    
    var activeSplitTransitionWrapperIDs: [String] {
        return viewMakers.compactMap {
            if $0.transition == .split { return $0.transitionWrapperID }
            return nil
        }
    }
    
    func add(_ viewMaker: TypeErasedExpansionLinkViewMaker) {
        viewMakers.append(viewMaker)
        
        withAnimation(.expandAnimation) {
            self.objectWillChange.send()
        }
    }
    
    func remove(_ viewMakerID: String) {
        viewMakers.removeAll(where: { $0.id == viewMakerID })
        
        withAnimation(.collapseAnimation) {
            self.objectWillChange.send()
        }
    }
}
