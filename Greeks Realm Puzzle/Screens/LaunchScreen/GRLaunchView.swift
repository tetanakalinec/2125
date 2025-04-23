import SwiftUI

struct GRLaunchView: View {
    
    @StateObject private var viewModel = GRLaunchViewModel()

    var body: some View {
        NavigationView {
            VStack {
               
                // - Transition
                NavigationLink(
                    destination: GRHomeView(),
                    isActive: $viewModel.navigateToHome
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
        .navigationViewStyle(StackNavigationViewStyle())
        .hideNavigationBar()
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

#Preview {
    GRLaunchView()
}
