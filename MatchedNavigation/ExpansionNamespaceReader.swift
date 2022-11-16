//
//  ExpansionNamespaceReader.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct ExpansionNamespaceReader<Content>: View where Content: View {
    var content: (Namespace.ID) -> Content
    
    @EnvironmentObject private var expander: Expander
    @Namespace private var placeholderNamespace
    
    var body: some View {
        content(expander.namespace ?? placeholderNamespace)
    }
}

struct ExpansionNamespaceReader_Previews: PreviewProvider {
    static var previews: some View {
        ExpansionNamespaceReader(content: { _ in EmptyView() })
    }
}
