//
//  LoginView.swift
//  fk_appointment
//
//  Created by Furkan on 16.10.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                ImageItems.Authentication.login.rawValue.image().resizable()
                    .scaledToFit()
                
                    .frame(width: 170, height: 170)
                Text(LocaleKeys
                        .Login.welcomeBack.rawValue.locale())
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: FontSizes.caption1, weight: .semibold))
                
                    .font(.system(size: FontSizes.title1, weight: .semibold)).foregroundColor(.teflon)
                HTextIconField(hint: LocaleKeys.General.emailHint.rawValue.locale(), iconName: IconItems.mail, text: $viewModel.emailValue, width: 25, height:25)
                HTextSecureIconField(hint: LocaleKeys.General.passwordHint.rawValue.locale(), iconName: IconItems.lock, text: $viewModel.passwordValue ).padding(.top, PagePadding.All.normal.rawValue)
               
                HStack {
                    
                    Spacer()
                    NavigationLink(destination: MainTabView().navigationBarHidden(true).navigationBarBackButtonHidden(true), isActive: Binding<Bool>(
                        get: { return !appState.shouldShowLoginView && viewModel.isLogged },
                        set: { _ in
                      
                        }
                    )) {
                        EmptyView()
                    }
                    
                    NavigationLink(
                        destination: SignUpView()
                    ) {
                        Text("Kaydol")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                }
                
                NormalButton(onTap: {
                    Task {
                        await viewModel.onLoginUser()
                    }
                    
                }, title: LocaleKeys.Login.signIn.rawValue).padding(.top, PagePadding.All.normal.rawValue)
                Spacer( ).frame(height:80 )
            }.padding(.horizontal, PagePadding.Horizontal.normal.rawValue)
            Spacer()
        }.onReceive(viewModel.$isLogged) { isLogged in
            if isLogged {
                if appState.shouldShowLoginView != false {
                    appState.shouldShowLoginView = false
                   
                }
               
            }
        }
    }
}


