import SwiftUI

enum Inknut: String {
    case bold = "Inknut Antiqua Bold"
}

extension Font {
    static func inknut(_ type: Inknut = .bold, size: CGFloat) -> Font {
        return Font.custom(type.rawValue, size: size)
    }
}
