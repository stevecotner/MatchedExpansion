//
//  CardItem.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import Foundation

protocol CardItem: Identifiable {
    var id: String { get }
    var title: String { get }
    var description: String { get }
}
