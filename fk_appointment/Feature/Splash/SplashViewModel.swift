    //
    //  SplashViewModel.swift
    //  fk_appointment
    //
    //  Created by Furkan on 10.03.2024.
    //

import Foundation


final class SplashViewModel : ObservableObject {
    @Published var generalError: String = ""
    @Published var isLoggedInBefore: Bool? = nil
    private let storageService : LocaleStorageService = LocaleStorageManager()
    
    func checkLoginStatus() -> Bool {
        if (storageService.load(objectType: UserLoginModel.self, forKey: LocaleStrogeKeys.User.loginInfo.rawValue)) != nil {
            return true
        }
        return false
    }
    
    func route() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.isLoggedInBefore = self.checkLoginStatus()
        }
    }
}




