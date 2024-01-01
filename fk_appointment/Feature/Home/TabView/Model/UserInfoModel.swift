//
//  AdvertisementModel.swift
//  fk_appointment
//
//  Created by Furkan on 7.11.2023.
//

import Foundation
struct UserInfoModel: Identifiable {
    var id: String?
    var city: String?
    var email: String?
    var name: String?
    var surname: String?
    var permission: Int?
    var town: String?
    var neighborhood: String?
    
    func with(id: String? = nil, city: String? = nil, email: String? = nil, name: String? = nil, surname: String? = nil, permission: Int? = nil, town: String? = nil, neighborhood: String? = nil) -> UserInfoModel {
          return UserInfoModel(
              id: id ?? self.id,
              city: city ?? self.city,
              email: email ?? self.email,
              name: name ?? self.name,
              surname: surname ?? self.surname,
              permission: permission ?? self.permission,
              town: town ?? self.town,
              neighborhood: neighborhood ?? self.neighborhood
          )
      }
    
    func toDictionary() -> [String: Any] {
           var dictionary: [String: Any] = [:]
           dictionary["id"] = id
           dictionary["city"] = city
           dictionary["email"] = email
           dictionary["name"] = name
           dictionary["surname"] = surname
           dictionary["permission"] = permission
           dictionary["town"] = town
           dictionary["neighborhood"] = neighborhood
           return dictionary
       }
}

extension UserInfoModel {
    static func fromDictionary(_ dictionary: [String: Any]) -> UserInfoModel {
        return UserInfoModel(
            id: dictionary["id"] as? String,
            city: dictionary["city"] as? String,
            email: dictionary["email"] as? String,
            name: dictionary["name"] as? String,
            surname: dictionary["surname"] as? String,
            permission: dictionary["permission"] as? Int,
            town: dictionary["town"] as? String,
            neighborhood: dictionary["neighborhood"] as? String
        )
    }
}


