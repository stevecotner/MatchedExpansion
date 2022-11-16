//
//  HowdyView.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct HowdyView: View {
    @State var cover = false
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            ScrollView {
                VStack(spacing: 20) {
                    Text("Howdy!!")
                        .matchedGeometryEffect(id: "howdy", in: namespace)
                    
                    Text("Hey!")
                    
                    Text("Hi!")
                    
                    Text("Hello!")
                    
                    Spacer()
                    
                    Button {
                        cover = true
                    } label: {
                        Text("Cover")
                    }
                }
            }
            .sheet(isPresented: $cover) {
                Text("hi...")
            }
        }
    }
}

struct HowdyView_Previews: PreviewProvider {
    static var previews: some View {
        HowdyView()
    }
}
