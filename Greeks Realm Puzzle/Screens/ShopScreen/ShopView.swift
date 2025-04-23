//
//  ShopView.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

struct ShopView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ShopViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            header
            Spacer()
            content
            Spacer()
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

extension ShopView {
    var header: some View {
        ZStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(.back)
                        .resizable()
                        .scaledToFit()
                }
                Spacer()
                Text("Shop".uppercased())
                    .foregroundStyle(.white)
                    .font(.inknut(size: 35))
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
            
            HStack {
                Image(.coin)
                Text("\(viewModel.coins)")
                    .foregroundStyle(.white)
                    .font(.inknut(size: 25))
                    .offset(y: -2)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(height: 50)
    }
}

extension ShopView {
    var content: some View {
        VStack(spacing: 20) {
            HStack {
                mapButton(index: 0, imageName: .shop1, isEnabled: true)
                mapButton(index: 1, imageName: .shop2, isEnabled: viewModel.isSecondMapEnabled)
            }

            HStack {
                mapButton(index: 2, imageName: .shop3, isEnabled: viewModel.isThirdMapEnabled)
                mapButton(index: 3, imageName: .shop4, isEnabled: viewModel.isFourthMapEnabled)
            }
        }
        .padding(.vertical)
        .customBackground(
            maxWidth: .infinity,
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlack
        )
    }

    @ViewBuilder
    func mapButton(index: Int, imageName: ImageResource, isEnabled: Bool) -> some View {
        Button {
            viewModel.selectMap(index: index)
        } label: {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 154, height: 204)
                .overlay(alignment: .bottomLeading) {
                    if !isEnabled {
                        Image(.coins)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: viewModel.selectedMapIndex == index ? 3 : 0)
                        .shadow(color: .white.opacity(0.8), radius: viewModel.selectedMapIndex == index ? 10 : 0)
                )
        }
    }
}

#Preview {
    ShopView()
}
