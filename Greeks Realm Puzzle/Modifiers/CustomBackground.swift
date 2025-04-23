import SwiftUI

struct CustomBackground: ViewModifier {

    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var cornerRadius: CGFloat = 36
    var strokeColor: Color
    var backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .background(
                backgroundColor
            )
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        strokeColor,
                        lineWidth: 2
                    )
            )
    }
}
