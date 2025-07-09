//
//  PrivacyView.swift
//  Greeks Realm Puzzle
//
//  Created by Protsak Dmytro on 14.05.2025.
//

import SwiftUI

struct PrivacyView: View {
        
    @AppStorage("firstOpenApp") var firstOpenApp = true
    @AppStorage("stringURL") var stringURL = ""

    @State private var showHome = false
    @State private var isContentLoaded = false
    
    var screenType: TypeScreen = .policy
    
    var body: some View {
        VStack {
            if isContentLoaded && stringURL.isEmpty {
                ScrollView(showsIndicators: true) {
                    Text(screenType.description)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                }
                actionButtons
            } else {
                WebViewContainer(stringURL: stringURL) {
                    isContentLoaded = true
                }
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                .ignoresSafeArea(.keyboard)
                .hideNavigationBar()
                .background(
                    LinearGradient(
                        gradient: .init(
                            colors: !stringURL.isEmpty ? [Color.black] : [
                                .privacyGradientTop,
                                .privacyGradientBottom
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            
            NavigationLink(
                destination: GRHomeView(),
                isActive: $showHome
            ) {
                EmptyView()
            }
        }
        .background(
            LinearGradient(
                gradient: .init(
                    colors: !stringURL.isEmpty ? [Color.black] : [
                        .privacyGradientTop,
                        .privacyGradientBottom
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onChange(of: stringURL) { newValue in
            if stringURL == "error" {
                showHome = true
            }
        }
        .hideNavigationBar()
        .onAppear {
            AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIDevice.current.setValue(UIInterfaceOrientation.unknown.rawValue, forKey: "orientation")
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
        .onDisappear {
            AppDelegate.orientationLock = .portrait
        }
    }
}

extension PrivacyView {
    var actionButtons: some View {
        HStack {
            Button {
                firstOpenApp = false
                showHome = true
            } label: {
                Image(.agree)
            }
            Spacer()
            Button {
                firstOpenApp = false
                exit(0)
            } label: {
                Image(.reject)
            }
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    PrivacyView()
}
