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
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 10)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(farewell.title).bold()
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer(minLength: 0)
                            }
                            .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                            .font(.title).bold()
                            .padding(.bottom, 4)
                            
                            Text(farewell.description)
                                .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    
                    details()
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                }
                .matchedGeometryEffect(id: "farewells" + "cardcontent" + farewell.id, in: namespace)
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                Button {
                    print("about to call collapse action...")
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
                withAnimation(.easeIn.delay(0.5)) {
                    shouldShowDetails = true
                }
            }
        }
    }
    
    func details() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
                .padding(.bottom, 12)
            Text("Details").bold()
                .padding(.bottom, 4)
            Text(farewell.details)
            
            Spacer()
        }
        .opacity(shouldShowDetails ? 1 : 0.001)
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
