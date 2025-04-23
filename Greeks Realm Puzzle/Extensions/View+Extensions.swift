import SwiftUI

extension View {
    
    func hideNavigationBar() -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

extension View {
    func customBackground(
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        cornerRadius: CGFloat,
        strokeColor: Color,
        backgroundColor: Color
    ) -> some View {
        self.modifier(
            CustomBackground(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                cornerRadius: cornerRadius,
                strokeColor: strokeColor,
                backgroundColor: backgroundColor
            )
        )
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
