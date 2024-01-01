//
//  SignUpViewMode.swift
//  fk_appointment
//
//  Created by Furkan on 28.10.2023.
//

import Foundation
import Firebase

final class SignUpViewModel : ObservableObject {
    
    @Published var nameValue: String = ""
    @Published var surnameValue: String = ""
    @Published var emailValue: String = ""
    @Published var passwordValue: String = ""
    @Published var passwordAgainValue: String = ""
    @Published var errorMessage: String = ""
    @Published var cityValue: String = ""
    @Published var townValue: String = ""
    @Published var neighborhoodValue: String = ""
    @Published var permissionValue: Int = 0
    @Published var isCreatedUser: Bool = false
    
    func onCreateUser () async {
        let result = await onCreateUser(name: nameValue, surname: surnameValue, email: emailValue, password: passwordValue, passwordAgain: passwordAgainValue, city: cityValue, town: townValue, permission: permissionValue, neighborhood: neighborhoodValue)
        if result == "true" {
            isCreatedUser = true
        } else {
            errorMessage = result
        }
    }
    
    
    
}

extension SignUpViewModel: SignUpUseCase{
    func onCreateUser(name:String , surname:String , email: String , password:String , passwordAgain: String, city:String , town: String, permission: Int, neighborhood:String ) async -> String {

        if name.isEmpty || surname.isEmpty || email.isEmpty || password.isEmpty || passwordAgain.isEmpty || city.isEmpty || town.isEmpty || neighborhood.isEmpty{
            return defaultErrorMessage
        }

        errorMessage = ""
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            errorMessage = "Lütfen farklı bir email giriniz."
        }
        
        let collection = Firestore.firestore().collection("User")
        
        let user = User(name: name, surname: surname, email: email, city: city, permission: permission, town: town, neighborhood: neighborhood)


      collection.addDocument(data: user.toDictionary())
        
        return "true"
        
        
    }
    
    
}
let defaultErrorMessage = "Lütfen tüm alanları doldurunuz."



    protocol SignUpUseCase {
        func onCreateUser(name:String , surname:String , email: String , password:String , passwordAgain: String, city:String , town: String, permission: Int, neighborhood:String ) async -> String
}
