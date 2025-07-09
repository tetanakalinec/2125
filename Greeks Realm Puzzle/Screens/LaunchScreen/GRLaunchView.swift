import SwiftUI

struct GRLaunchView: View {
    
    @AppStorage("firstOpenApp") var firstOpenApp = true
    @AppStorage("stringURL") var stringURL = ""
    
    @State private var showPrivacy = false
    @State private var showHome = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: PrivacyView(),
                    isActive: $showPrivacy
                ) {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: GRHomeView(),
                    isActive: $showHome
                ) {
                    EmptyView()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    Color(.white)
                    Image(.launchBackground)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            )
        }
        .hideNavigationBar()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if !firstOpenApp {
                    showHome = true
                } else {
                    showPrivacy = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    GRLaunchView()
}
