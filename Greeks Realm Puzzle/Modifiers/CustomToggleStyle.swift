//
//  CustomToggleStyle.swift
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .foregroundColor(.white)
                .font(.inknut(size: 25))
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        configuration.isOn
                        ? LinearGradient(
                            colors: [.green],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        : LinearGradient(
                            colors: [.customGray],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 51, height: 31)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 27, height: 27)
                    .offset(x: configuration.isOn ? 10 : -10)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    GRMenuView()
}
