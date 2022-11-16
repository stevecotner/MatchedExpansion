//
//  Greeting.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import Foundation

struct Greeting: CardItem {
    let id: String = UUID().uuidString
    let title: String
    let description: String
}
