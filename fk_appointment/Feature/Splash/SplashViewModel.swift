    //
    //  SplashViewModel.swift
    //  fk_appointment
    //
    //  Created by Furkan on 10.03.2024.
    //

import Foundation
import Firebase


final class SplashViewModel : ObservableObject {
    @Published var generalError: String = ""
    @Published var isLoggedInBefore: Bool? = nil
    private let storageService : LocaleStorageService = LocaleStorageManager()
    
    func checkLoginStatus()  async -> Bool {
        let user = storageService.load(objectType: UserLoginModel.self, forKey: LocaleStrogeKeys.User.loginInfo.rawValue)
        if ( user != nil ){
            do {
                let result = try await Auth.auth().signIn(withEmail: user?.userName ?? "", password: user?.password ?? "")
                CurrentUser.shared.setUserID(result.user.uid)
                
                
                return true
            } catch {
                return false
            }
          
        }
        return false
    }
    
    func route() async {
        let result = await  self.checkLoginStatus()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)  {
            self.isLoggedInBefore = result
        }
    }
}




