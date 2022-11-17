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
    let titleFontSize: CGFloat = 22.0
    let subtitleFontSize: CGFloat = 20.0
    
    var body: some View {
        GeometryReader { geometry in
            

            ExpansionNamespaceReader { namespace in
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 7) {
                                HStack {
                                    Text(farewell.title)
                                    Spacer(minLength: 0)
                                }
                                .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                                .font(.system(size: 20.0, weight: .semibold))
                                
                                HStack {
                                    Text(farewell.description)
                                    Spacer(minLength: 0)
                                }
                                .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
                                .font(.system(size: 18.18, weight: .regular))
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                        .padding(.top, 15)
                        
                        Divider()
                            .padding(.bottom, 16)
                        
                        // Image
                        Image(farewell.imageName ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "farewells" + "image" + farewell.id, in: namespace)
                            .frame(width: geometry.size.width - 40, height: geometry.size.width - 40)
                            .mask(
                                RoundedRectangle(cornerRadius: 12)
                                    .matchedGeometryEffect(id: "farewells" + "imagemask" + farewell.id, in: namespace)
                            )
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        
                        details()
                            .padding(.horizontal, 20)
                        
                        Spacer()
                        
                    }
                    .matchedGeometryEffect(id: "farewells" + "cardcontent" + farewell.id, in: namespace)
                }
                .frame(maxHeight: .infinity)
                .safeAreaInset(edge: .bottom, content: {
                    Button {
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation(.linear) {
                            shouldShowDetails = true
                        }
                    }
                }
            }
        }
    }
    
    func details() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if shouldShowDetails {
                HStack {
                    Text("Details").bold()
                    Spacer(minLength: 0)
                }
                .padding(.bottom, 4)
                
                HStack {
                    Text(farewell.details)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
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
