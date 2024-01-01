//
//  LoginViewModel.swift
//  fk_appointment
//
//  Created by Furkan on 26.10.2023.
//

import Foundation
import Firebase

final class LoginViewModel: ObservableObject {
    @Published var emailValue: String = "furkankalender46@gmail.com"
    @Published var passwordValue: String = "123456"
    @Published var isLogged: Bool = false
    @Published var errorMessage: String = ""
    
    func onLoginUser() async  {
       let result = await onLoginUser(email: emailValue, password: passwordValue)
        if result == "true" {
            isLogged = true
        }
    }
  
}

extension LoginViewModel: LoginUseCase {
    func onLoginUser(email: String, password: String) async -> String {
        guard !email.isEmpty else { return "" }
        guard !password.isEmpty else {return "" }
        errorMessage = ""

      
        do {
             let result = try await Auth.auth().signIn(withEmail: email, password: password)
            CurrentUser.shared.setUserID(result.user.uid)
        } catch {
            errorMessage = "Kullanıcı adı veya şifre yanlış."
          
        }
        guard errorMessage.isEmpty else { return errorMessage }
        
        return "true"
    }
    func onSaveUserInformation(emial: String, password: String) -> Bool {
    return false
    }
}
protocol LoginUseCase {
    func onLoginUser(email: String , password: String) async -> String
    func onSaveUserInformation(emial: String, password: String)-> Bool
}

