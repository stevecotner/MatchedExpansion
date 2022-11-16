//
//  ExpansionView.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct ExpansionView<Content>: View where Content: View {
    var content: (Namespace.ID) -> Content
    
    @StateObject private var expander = Expander()
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
                
                ForEach(Array(expander.viewMakers.enumerated()), id: \.element.id) { index, viewMaker in
                    ZStack(alignment: .top) {
                        viewMaker.content()
                        
                        if viewMaker.showsXButton {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        removeAndResetActive(viewMaker)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 26)
                                            .foregroundColor(.black)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    .opacity(index < expander.viewMakers.count - 1 ? 0 : 1)
                    .frame(
                        height: index < expander.viewMakers.count - 1
                                && expander.viewMakers.count > index + 1
                                && expander.viewMakers[index + 1].transition.isSplit == true ?
                                geometry.size.height * 2 : geometry.size.height
                        )
                    .offset(
                        y: index < expander.viewMakers.count - 1
                        && expander.viewMakers.count > index + 1
                        && expander.viewMakers[index + 1].transition.isSplit == true ?
                        -geometry.size.height : 0)
                }
            }
            .environmentObject(expander)
            .onAppear() {
                expander.namespace = namespace
                expander.totalHeight = geometry.size.height
            }
        }
    }
    
    func removeAndResetActive(_ viewMaker: TypeErasedExpansionLinkViewMaker) {
        viewMaker.resetActive()
        expander.remove(viewMaker.id)
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
    
    static var expandAnimation: Self {
        .interpolatingSpring(mass: 0.039, stiffness: 2.75, damping: 0.55, initialVelocity: 0.1)
    }
}
