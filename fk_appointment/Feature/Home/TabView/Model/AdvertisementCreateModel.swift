//
//  UserModel.swift
//  fk_appointment
//
//  Created by Furkan on 28.10.2023.
//

import Foundation

struct AdvertisementCreateModel: Identifiable {
    var id: String?
    
    var adName: String, adCost: Double, nameOfBerber: String, imageUrl: String, location: String, favUsers: String
    
    init(id: String? = nil, adName: String, adCost: Double, nameOfBerber: String, imageUrl: String, location: String, favUsers: String) {
        self.id = id
        self.adName = adName
        self.adCost = adCost
    
        self.nameOfBerber = nameOfBerber
        self.imageUrl = imageUrl
        self.location = location
        self.favUsers = favUsers
    }
    
    func toDictionary() -> [String: Any] {
         return [
             "Cost": adCost,
             "ImageUrl": imageUrl,
             "Location": location,
             "Name": adName,
             "NameOfBerber": nameOfBerber,
             "FavUsers": favUsers
         ]
     }
}






