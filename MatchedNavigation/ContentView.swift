//
//  ContentView.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct ContentView: View {
    @State var expand = false
    
    var body: some View {
        ExpansionView { _ in
            ListOfCardDecks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
