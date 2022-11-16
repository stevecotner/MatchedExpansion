//
//  GreetingCardContent.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct GreetingCardContent: View {
    let greeting: Greeting
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            VStack(alignment: .leading) {
                Text(greeting.title).bold()
                    .matchedGeometryEffect(id: "greetings" + "cardtitle" + greeting.id, in: namespace)
                Text(greeting.description)
                    .matchedGeometryEffect(id: "greetings" + "carddescription" + greeting.id, in: namespace)
            }
        }
    }
}

struct GreetingCardContent_Previews: PreviewProvider {
    static var previews: some View {
        GreetingCardContent(greeting: Greeting(title: "hi", description: "hey"))
    }
}
