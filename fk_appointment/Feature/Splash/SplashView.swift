    //
    //  SplashView.swift
    //  fk_appointment
    //
    //  Created by Furkan on 10.03.2024.
    //

import Foundation
import SwiftUI

struct SplashView: View {
    @ObservedObject private var viewModel = SplashViewModel()
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        ImageItems.Authentication.login.rawValue.image()
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 170)
                            .padding()
                        Text("Berber Randevu Uygulaman")
                            .font(.headline)
                            .padding(.top, 20)
                        
                        NavigationLink("", isActive:  Binding<Bool>(
                            get: { viewModel.isLoggedInBefore ?? false },
                            set: { _ in }
                        ) ){
                            MainTabView().navigationBarHidden(true).navigationBarBackButtonHidden(true)
                        }
                        NavigationLink("", isActive:  Binding<Bool>(
                            get: { !(viewModel.isLoggedInBefore ?? true) },
                            set: { _ in }
                        )){
                            LoginView().navigationBarHidden(true).navigationBarBackButtonHidden(true)
                        }
                        Spacer()
                    }
                }
            }
            
        }.onAppear{
            viewModel.route()
        } .padding(.vertical,0).listStyle(.plain).navigationBarHidden(true)
        
    }
    
}

