import SwiftUI

struct GRTextView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var screenType: TypeScreen
    
    var body: some View {
        VStack(spacing: 10) {
            header
            description
            buttons
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity)
        .hideNavigationBar()
        .background(
            ZStack {
                Color(.white)
                Image(.emptyBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Color(.black.withAlphaComponent(0.1)).ignoresSafeArea()
            }
        )
    }
}

// MARK: - Header

extension GRTextView {
    var header: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(.back)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
            Text(screenType.title.uppercased())
                .font(.inknut(size: 20))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(.back)
                    .resizable()
                    .scaledToFit()
            }
            .opacity(0)
        }
        .frame(height: 50)
    }
}

// MARK: - Description

extension GRTextView {
    var description: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Text(screenType.description)
                    .font(.inknut(size: 20))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(0)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .customBackground(
            maxWidth: .infinity,
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlack
        )
    }
}

// MARK: - Buttons

extension GRTextView {
    var buttons: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(.agree)
            })
            
            Spacer()
            
            Button(action: {
                exit(0)
            }, label: {
                Image(.reject)
            })
        }
    }
}

#Preview {
    GRTextView(screenType: .terms)
}


enum TypeScreen {
    case policy
    case terms
    
    var title: String {
        switch self {
        case .policy:
            "Privacy Policy"
        case .terms:
            "Terms of Use"
        }
    }
    
    var description: String {
        switch self {
        case .terms:
                    """
                Welcome to our game! By accessing and playing our game, you agree to comply with the following Terms of Use. Please read them carefully.

                1. Acceptance of Terms:
                - By downloading, installing, or using our game, you agree to be bound by these Terms of Use and our Privacy Policy. If you do not agree with these terms, please do not use the game.

                2. License to Use:
                - We grant you a limited, non-exclusive, non-transferable, and revocable license to use our game for personal entertainment purposes only. You may not use the game for any commercial purpose without our express permission.

                3. User Conduct:
                - You agree to use the game in a manner that is lawful and respectful of others. You may not use the game to engage in any illegal activities, distribute harmful software, or harass other players.

                4. Intellectual Property:
                - All content, features, and functionality of the game, including but not limited to graphics, designs, logos, and software, are the intellectual property of the game developers and are protected by copyright and trademark laws.

                5. Updates and Modifications:
                - We may update or modify the game at any time without prior notice. These updates may include new features, bug fixes, or other changes to enhance the game. We reserve the right to discontinue or suspend the game at any time.

                6. Limitation of Liability:
                - We are not responsible for any damages or losses resulting from your use of the game, including but not limited to data loss, device damage, or any other indirect, incidental, or consequential damages.

                7. Termination:
                - We reserve the right to terminate or suspend your access to the game if you violate these Terms of Use. Upon termination, your right to use the game will cease immediately.

                8. Governing Law:
                - These Terms of Use are governed by and construed in accordance with the laws of the jurisdiction in which the game developer is based. Any disputes arising from these terms shall be resolved in the courts of that jurisdiction.

                Thank you for playing our game! If you have any questions about these Terms of Use, please contact us through the support section in the game.
                """
        case .policy:
                    """
                We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you play our game.

                1. Information We Collect:
                - We may collect personal information, such as your name, email address, and other contact details, when you create an account or interact with certain features of the game.
                - We collect non-personal information, such as gameplay data, device information, and usage statistics, to improve our game and provide a better user experience.

                2. How We Use Your Information:
                - Your personal information is used to manage your account, provide customer support, and communicate with you about updates or promotions.
                - Non-personal information is used to analyze game performance, optimize features, and enhance your overall experience.

                3. Sharing Your Information:
                - We do not share your personal information with third parties except as necessary to provide the services or as required by law.
                - Non-personal information may be shared with our partners and service providers to help improve the game.

                4. Data Security:
                - We implement industry-standard security measures to protect your data from unauthorized access, disclosure, or loss.
                - While we strive to protect your personal information, please note that no security system is completely impenetrable.

                5. Your Rights:
                - You have the right to access, correct, or delete your personal information at any time. Please contact us if you wish to exercise these rights.
                - You can opt-out of receiving promotional communications by following the instructions in the messages you receive.

                6. Changes to This Policy:
                - We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the new policy in the game or by sending an email.

                By using our game, you agree to the terms of this Privacy Policy. If you have any questions or concerns, please contact us through the support section in the game.
                """
        }
    }
}
