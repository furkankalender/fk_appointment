//
//  LocaleKeys.swift
//  fk_appointment
//
//  Created by Furkan on 16.10.2023.
//

import SwiftUI

struct LocaleKeys {
    enum Auth: String {
        case google = "singInGoogle"
        case custom = "signupWithEmail"
    }
    
    enum Login: String {
        case welcomeBack
        case signIn
        case createAccount
        case terms = "termsAndCondition"
        
    }
    enum General: String {
        case emailHint
        case passwordHint
        case nameHint
        case surnameHint
        case passwordAgainHint
        case cityHint
        case townHint
        case neighborhoodHint
        case permissionHint
        case createAd
        case adHint
        case locationHint
        case nameOfBerberHint
        case costHint
        
    }
    enum TabView: String {
        case home = "tabHome"
        case create = "tabCreate"
        case wishlist = "tabWishlist"
        case account = "tabAccount"
    }
    
    
}
extension String {
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
