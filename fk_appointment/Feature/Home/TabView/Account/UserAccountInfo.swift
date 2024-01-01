//
//  UserAccountInfo.swift
//  fk_appointment
//
//  Created by Furkan on 28.12.2023.
//

import SwiftUI
struct UserAccountInfo: View {
    @ObservedObject private var viewModel = UserAccountInfoViewModel()
    
    let  iconSize: CGFloat = 22
    
    var body: some View {
        NavigationView {
            ScrollView {
                Images.userAvatar.rawValue.image()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading) {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    
                    InfoText(header: "Name", content: viewModel.userInfo.name ?? "")
                    InfoText(header: "Surname", content: viewModel.userInfo.surname ?? "")
                    InfoText(header: "Email", content: viewModel.userInfo.email ?? "")
                    InfoText(header: "City", content: viewModel.userInfo.city ?? "")
                    InfoText(header: "Town", content: viewModel.userInfo.town ?? "")
                    InfoText(header: "Neighborhood", content: viewModel.userInfo.neighborhood ?? "")
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Account")
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchAdvertisements()
        }
    }
}

struct InfoText: View {
    
    var header: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .foregroundColor(Color.gray.opacity(0.9))
                .font(.system(size: 18))
                .disabled(true)
                .padding(.bottom, 2)
            
            Text(content)
                .foregroundColor(Color.black)
                .font(.system(size: 18))
                .disabled(false)
                .padding(.bottom, 10)
        }
    }
}
