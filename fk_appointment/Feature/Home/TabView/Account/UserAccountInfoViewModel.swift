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

final class UserAccountInfoViewModel : ObservableObject{
    @Published var generalError: String = ""
    @Published var isLoading: Bool = false
    @Published var userInfo : UserInfoModel = UserInfoModel()
    
    func fetchAdvertisements() {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                
                try await getUserInfo()
                DispatchQueue.main.async {
                    print("Produc------- \(self.userInfo)")
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

extension UserAccountInfoViewModel: UserAccountInfoUseCase{
        
        func getUserInfo() async throws-> Void{
            do {
                
                let db = Firestore.firestore()
                let ref = db.collection("User")
                
                ref.getDocuments{
                    snapshot, error in
                    guard error == nil else {
                        print("Hata:         \(String(describing: error))")
                        return
                    }
                    
                    if let snapshot = snapshot {
                        
                        for document in snapshot.documents {
                            let data = document.data()
                            let user =  UserInfoModel.fromDictionary( data )
                            
                            DispatchQueue.main.async {
                                self.userInfo = user
                            }
                            
                            
                        }
                    }
                }
            }
        }}
    

    protocol UserAccountInfoUseCase{
        func getUserInfo()async throws -> Void
        
    }
    
    
