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
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(greeting.title)
                    Spacer(minLength: 0)
                }
                .matchedGeometryEffect(id: "greetings" + "cardtitle" + greeting.id, in: namespace)
                .font(.system(size: 18, weight: .semibold))
                
                HStack {
                    Text(greeting.description)
                    Spacer(minLength: 0)
                }
                .matchedGeometryEffect(id: "greetings" + "carddescription" + greeting.id, in: namespace)
                    .font(.system(size: 16.36, weight: .regular))
            }
        }
    }
}

struct GreetingCardContent_Previews: PreviewProvider {
    static var previews: some View {
        GreetingCardContent(greeting: Greeting(title: "hi", description: "hey"))
    }
}
