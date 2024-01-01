//
//  HomeViewModel.swift
//  fk_appointment
//
//  Created by Furkan on 7.11.2023.
//

import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseStorage
final class HomeViewModel : ObservableObject {
    @Published var generalError: String = ""
    @Published var isLoading: Bool = false
    @Published var advertisements : [Advertisement]  = []
    
    
    func toggleFav(for advertisement: Advertisement) {
        if let index = advertisements.firstIndex(where: { $0.id == advertisement.id }) {
            advertisements[index] = advertisement.with( favUsers:  getFavorites(for: advertisement))
            let product:  Advertisement = advertisements[index]
            let collection = Firestore.firestore().collection("Advertisement").document(product.id ?? "").updateData(product.toDictionary()){error in
                if let error = error {
                    print("\(error.localizedDescription) Update fav error, not found document")
                    return
                }
            }
            
            
        }
        
    }
    func getFavorites(for advertisement: Advertisement) -> String {
        
        let userID: String = CurrentUser.shared.userID ?? ""
        
        var favUsersArray = advertisement.favUsers?.components(separatedBy: ",") ?? []
        if ((favUsersArray.isEmpty)){
            return "\(userID),"
        }
        
        if let index = favUsersArray.firstIndex(of: userID) {
            favUsersArray.remove(at: index)
        } else {
            
            favUsersArray.append(userID)
        }
        
        let newFavUsers = favUsersArray.joined(separator: ",")
        
        
        return newFavUsers
    }
    
    
    func fetchAdvertisements() {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                
                try await getAdvertisements()
                DispatchQueue.main.async {
                    print("Produc------- \(self.advertisements.count)")
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.generalError = "Beklenmedik bir hata meydana geldi"
                }
                
                
            }
        }
    }
    
    func fetchUserFavoritesAdvertisements() {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                
                try await getUserFavoriteAdvertisements()
                DispatchQueue.main.async {
                    print("Produc------- \(self.advertisements.count)")
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.generalError = "Beklenmedik bir hata meydana geldi"
                }
                
                
            }
        }
    }
    
}



extension HomeViewModel: HomeCase{
    func getUserFavoriteAdvertisements() async throws-> Void{
        do {
            
            let db = Firestore.firestore()
            let ref = db.collection("Advertisement")
            let userID = CurrentUser.shared.userID
            ref.getDocuments{
                snapshot, error in
                guard error == nil else {
                    print("Hata:  \(String(describing: error))")
                    return
                }
                
                if let snapshot = snapshot {
                    self.advertisements.removeAll()
                    for document in snapshot.documents {
                        let data = document.data()
                        let advert =  Advertisement().convert(firestoreData: data)
                        let advertWithId = advert.with(imageURL: advert.imageURL, id: document.documentID, nameOfBerber: advert.nameOfBerber, location: advert.location, cost: advert.cost, favUsers: advert.favUsers, name: advert.name)
                        
                        DispatchQueue.main.async {
                            if(advertWithId.favUsers?.contains(userID ?? "") ?? false) {
                                self.advertisements.append(advertWithId)
                            }
                            
                        }
                        
                        
                    }
                }
            }
        }
    }
    func getAdvertisements() async throws-> Void{
        do {
            
            let db = Firestore.firestore()
            let ref = db.collection("Advertisement")
            
            ref.getDocuments{
                snapshot, error in
                guard error == nil else {
                    print("Hata:         \(String(describing: error))")
                    return
                }
                
                if let snapshot = snapshot {
                    self.advertisements.removeAll()
                    for document in snapshot.documents {
                        let data = document.data()
                        let advert =  Advertisement().convert(firestoreData: data)
                        let advertWithId = advert.with(imageURL: advert.imageURL, id: document.documentID, nameOfBerber: advert.nameOfBerber, location: advert.location, cost: advert.cost, favUsers: advert.favUsers, name: advert.name)
                        
                        DispatchQueue.main.async {
                            self.advertisements.append(advertWithId)
                        }
                        
                        
                    }
                }
            }
        }
    }}


protocol HomeCase{
    func getAdvertisements()async throws -> Void
    func getUserFavoriteAdvertisements()async throws -> Void
}


