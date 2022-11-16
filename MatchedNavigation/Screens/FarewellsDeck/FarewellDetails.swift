//
//  FarewellDetails.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/16/22.
//

import SwiftUI

struct FarewellDetails: View {
    let farewell: Farewell
    let collapseAction: () -> Void
    
    @State var shouldShowDetails = false
    let titleFontSize: CGFloat = 28.0
    let subtitleFontSize: CGFloat = 22.0
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(farewell.title).bold()

                                Spacer(minLength: 0)
                            }
                            .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                            .font(.system(size: titleFontSize))
                            
                            HStack {
                                Text(farewell.description)
                                Spacer(minLength: 0)
                            }
                            .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
                            .font(.system(size: subtitleFontSize))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    .padding(.top, 15)
                    
                    details()
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                }
                .matchedGeometryEffect(id: "farewells" + "cardcontent" + farewell.id, in: namespace)
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                Button {
                    shouldShowDetails = false
                    
                    collapseAction()
                } label: {
                    Text("Done")
                }
                .buttonStyle(PillButtonStyle())
            })
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.01), radius: 18, x: 0, y: 3)
                    .edgesIgnoringSafeArea([.top, .bottom])
                    .matchedGeometryEffect(id: "Farewells" + farewell.id + "card" + "background", in: namespace)
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    withAnimation(.easeIn) {
                        shouldShowDetails = true
                    }
                }
            }
            
        }
    }
    
    func details() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if shouldShowDetails {
                Divider()
                    .padding(.bottom, 12)
                Text("Details").bold()
                    .padding(.bottom, 4)
                Text(farewell.details)
            }
        }
    }
}

struct FarewellDetails_Previews: PreviewProvider {
    static var previews: some View {
        FarewellDetails(
            farewell: Farewell(
                title: "bye",
                description: "...",
                details: "..."
            ),
            collapseAction: {}
        )
    }
}
