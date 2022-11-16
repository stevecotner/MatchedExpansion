//
//  ExpansionView.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct ExpansionView<Content>: View where Content: View {
    var content: (Namespace.ID) -> Content
    
//    @State private var viewMakers: [TypeErasedExpansionLinkViewMaker] = []
    
    @StateObject var expander = Expander()
    
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                content(namespace)
                    .opacity(expander.viewMakers.count > 0 ? 0 : 1)
                    .frame(height: expander.viewMakers.count > 0 && expander.viewMakers.first?.transition.isSplit == true ? geometry.size.height * 2 : geometry.size.height)
                    .offset(y: expander.viewMakers.count > 0 && expander.viewMakers.first?.transition.isSplit == true ?
                            -geometry.size.height :
                            0)
                
                // TODO: consider iterating over range of count, not actual viewMakers.
                ForEach(Array(expander.viewMakers.enumerated()), id: \.element.id) { index, viewMaker in
                    ZStack(alignment: .top) {
                        viewMaker.content()
                        
                        if viewMaker.showsX {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        removeAndResetActive(viewMaker)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 23)
                                            .foregroundColor(.black)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .opacity(index < expander.viewMakers.count - 1 ? 0 : 1)
                    .frame(
                        height: index < expander.viewMakers.count - 1
                                && expander.viewMakers.count > index + 1
                                && expander.viewMakers[index + 1].transition.isSplit == true ?
                                geometry.size.height * 2 : geometry.size.height
                        )
//                        height: geometry.size.height
//                        )
                    .offset(
                        y: index < expander.viewMakers.count - 1
                        && expander.viewMakers.count > index + 1
                        && expander.viewMakers[index + 1].transition.isSplit == true ?
                        -geometry.size.height : 0)
                }
            }
            .environmentObject(expander)
            .onAppear() {
                expander.add = addTypeErasedViewMaker
                expander.remove = removeTypeErasedViewMaker
                expander.namespace = namespace
                expander.totalHeight = geometry.size.height
            }
        }
    }
    
    func addTypeErasedViewMaker(_ viewMaker: TypeErasedExpansionLinkViewMaker) {
        expander.viewMakers.append(viewMaker)
        
        withAnimation(.interpolatingSpring(mass: 0.039, stiffness: 2.75, damping: 0.55, initialVelocity: 0.1)) {
            expander.objectWillChange.send()
        }
    }
    
    func removeTypeErasedViewMaker(_ id: String) {
        expander.viewMakers.removeAll(where: { $0.id == id })
        
        withAnimation(.collapseAnimation) {
            expander.objectWillChange.send()
        }
    }
    
    func removeAndResetActive(_ viewMaker: TypeErasedExpansionLinkViewMaker) {
        viewMaker.resetActive()
        expander.viewMakers.removeAll(where: { $0.id == viewMaker.id })
        
        withAnimation(.collapseAnimation) {
            expander.objectWillChange.send()
        }
    }
}

struct ExpansionLinkViewMaker<Content> where Content: View {
    var id: String
    var transitionWrapperID: String
    let showsX: Bool
    let transition: ExpansionTransition
    var resetActive: () -> Void
    var content: () -> Content
    var typeErasedViewMaker: TypeErasedExpansionLinkViewMaker {
        let anyfiedContent = { AnyView(content()) }
        return TypeErasedExpansionLinkViewMaker(
            id: id,
            transitionWrapperID: transitionWrapperID,
            showsX: showsX,
            transition: transition,
            resetActive: resetActive,
            content: anyfiedContent
        )
    }
}

struct TypeErasedExpansionLinkViewMaker {
    var id: String
    var transitionWrapperID: String
    let showsX: Bool
    let transition: ExpansionTransition
    var resetActive: () -> Void
    var content: () -> AnyView
}

class Expander: ObservableObject {
    var add: ((TypeErasedExpansionLinkViewMaker) -> Void)?
    var remove: ((String) -> Void)?
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
}

struct ExpansionView_Previews: PreviewProvider {
    static var previews: some View {
//        ExpansionView()
        EmptyView()
    }
}

extension Animation {
    static var collapseAnimation: Self {
        interpolatingSpring(mass: 0.039, stiffness: 4.5, damping: 0.95, initialVelocity: 0.1)
    }
}
