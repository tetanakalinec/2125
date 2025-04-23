//
//  AccountView.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

struct AccountView: View {
    
    // MARK: - @State
    @State private var inputImage: UIImage?
    
    // MARK: - @Environment
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - @StateObject
    @StateObject var viewModel = AccountViewModel()
    
    // MARK: - @ObservedObject
    @ObservedObject var imageManager = PhotoManager.shared
    
    var body: some View {
        VStack {
            header
            accountInfoContainer
                .padding(.top, 20)
            Spacer()
        }
        .padding(20)
        .hideNavigationBar()
        .background(
            ZStack {
                Color(.white)
                Image(.emptyBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Color.black.opacity(0.1).ignoresSafeArea()
            }
                .ignoresSafeArea(.keyboard)
        )
        .ignoresSafeArea(.keyboard)
        .actionSheet(isPresented: $viewModel.showActionSheet) {
            ActionSheet(
                title: Text("Select Image Source"),
                buttons: [
                    .default(Text("Album")) {
                        viewModel.showingImagePicker = true
                    },
                    .default(Text("Camera")) {
                        viewModel.checkCameraPermission()
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: loadImage) {
            AlbumPicker(image: $inputImage)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.showingCameraPicker, onDismiss: loadImage) {
            CameraPicker(image: $inputImage)
                .ignoresSafeArea()
        }
    }
}


// MARK: - Header

extension AccountView {
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
            Text("My Account")
                .foregroundStyle(.white)
                .font(.inknut(size: 30))
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
        .ignoresSafeArea(.keyboard)
    }
}

extension AccountView {
    var accountInfoContainer: some View {
        VStack(spacing: 0) {
            accountPhotoContainer
            nameTextField
        }
        .padding()
        .customBackground(
            maxWidth: .infinity,
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlack
        )
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Account Photo Container

extension AccountView {
    var accountPhotoContainer: some View {
        VStack {
            if let profileImage = imageManager.profileImage {
                Button {
                    viewModel.showActionSheet = true
                } label: {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: 100,
                            height: 100
                        )
                        .clipped()
                }
            } else {
                Button {
                    viewModel.showActionSheet = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(
                            width: 100,
                            height: 100
                        )
                }
            }
        }
        .padding(.vertical, 10)
    }
}

// MARK: - Name TextField

extension AccountView {
    var nameTextField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("User name")
                .foregroundStyle(.white)
                .font(.inknut(size: 20))
            TextField(
                "",
                text: $viewModel.name,
                prompt: Text("Enter your name...")
                    .foregroundColor(.white)
                    .font(.inknut(size: 20))
            )
            .font(.inknut(size: 22))
            .foregroundStyle(.white)
            .padding()
            .customBackground(
                maxWidth: .infinity,
                maxHeight: 35,
                cornerRadius: 10,
                strokeColor: .white,
                backgroundColor: .customBlack
            )
            .offset(y: -10)
        }
    }
}

// MARK: - Private Methods

private extension AccountView {
    func loadImage() {
        if let inputImage = inputImage {
            imageManager.profileImage = inputImage
        }
    }
}


#Preview {
    AccountView()
}
