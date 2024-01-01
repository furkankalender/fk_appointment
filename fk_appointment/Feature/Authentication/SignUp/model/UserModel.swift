//
//  UserModel.swift
//  fk_appointment
//
//  Created by Furkan on 28.10.2023.
//

import Foundation

struct User: Identifiable {
    var id: String?
    var name: String
    var surname: String
    var email: String
    var city: String
    var permission: Int
    var town: String
    var neighborhood: String
    
    init(id: String? = nil, name: String, surname: String, email: String, city: String, permission: Int, town: String, neighborhood: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.city = city
        self.permission = permission
        self.town = town
        self.neighborhood = neighborhood
    }
    
    func toDictionary() -> [String: Any] {
         return [
             "name": name,
             "surname": surname,
             "email": email,
             "city": city,
             "permission": permission,
             "town": town,
             "neighborhood": neighborhood
         ]
     }
}






