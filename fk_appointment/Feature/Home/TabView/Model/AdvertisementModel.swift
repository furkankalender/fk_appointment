//
//  AdvertisementModel.swift
//  fk_appointment
//
//  Created by Furkan on 7.11.2023.
//

import Foundation
struct Advertisement: Identifiable {
    var id: String?
    var imageURL: URL?
    var nameOfBerber: String?
    var location: String?
    var cost: Double?
    var favUsers: String?
    var name: String?
    
    func isFav() -> Bool {
        let result =  self.favUsers?.contains(CurrentUser.shared.userID ?? "") ?? false
        return result
    }
    
    func with(
        imageURL: URL? = nil,
        id: String? = nil,
        nameOfBerber: String? = nil,
        location: String? = nil,
        cost: Double? = nil,
        favUsers: String? = nil,
        name: String? = nil
    ) -> Advertisement {
        return Advertisement(
            id: id ?? self.id,
            imageURL: imageURL ?? self.imageURL,
            nameOfBerber: nameOfBerber ?? self.nameOfBerber,
            location: location ?? self.location,
            cost: cost ?? self.cost,
            favUsers:  favUsers ?? self.favUsers,
            name: name ?? self.name
        )
    }
    func toDictionary() -> [String: Any] {
        return [
            "Cost": cost,
            "Location": location,
            "Name": name,
            "NameOfBerber": nameOfBerber,
            "FavUsers": favUsers
        ]
    }
    func convert(firestoreData: [String: Any]) -> Advertisement {
        let imageURLString = firestoreData["ImageUrl"] as? String
        let imageURL = URL(string: imageURLString ?? "")
        let nameOfBerber = firestoreData["NameOfBerber"] as? String
        let location = firestoreData["Location"] as? String
        let cost = firestoreData["Cost"] as? Double
        let name = firestoreData["Name"] as? String
        let favUsers = firestoreData["FavUsers"] as? String
        let id = firestoreData["id"] as? String
        
        return with(imageURL: imageURL,id: id, nameOfBerber: nameOfBerber, location: location, cost: cost, favUsers: favUsers, name: name)
    }
}


