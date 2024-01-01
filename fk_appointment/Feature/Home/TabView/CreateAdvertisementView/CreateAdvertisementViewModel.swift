//
//  CreateAdvertisementViewModel.swift
//  fk_appointment
//
//  Created by Furkan on 9.11.2023.
//

import Foundation
import FirebaseStorage
import Firebase
import UIKit
import SwiftUI


final class CreateAdvertisementViewModel : ObservableObject{
    @Published var adName: String = ""
    @Published var adCost: Double = 0
    @Published var nameOfBerber: String = ""
    @Published var imageUrl: String = ""
    @Published var location: String = ""
    @Published var errorMessage: UploadError = UploadError.nothing
    @Published var selectedImage: UIImage?
    var customImageUrl: String = ""
    @Published var isLoading: Bool = false
    @Published var isDone: Bool = false
    var path: String = ""

    func addAdvertisement() async {
        isLoading = true
        await createAdvertisement()
        isLoading = false
    }
}

extension CreateAdvertisementViewModel: CreateAdvertisementUseCase {
    func createAdvertisement() async {
        if (adName.isEmpty || adCost.isEqual(to: 0) || nameOfBerber.isEmpty || location.isEmpty  || selectedImage == nil) {
            self.errorMessage = UploadError.emptyFieldError
            return
        }

        
       
          let result =  await self.uploadImageData()
        if result == false {
            self.errorMessage = UploadError.uploadFailed
            return
        }
       
        let collection = Firestore.firestore().collection("Advertisement")

            let advert = AdvertisementCreateModel(adName: self.adName, adCost: self.adCost, nameOfBerber: self.nameOfBerber, imageUrl: path, location: self.location,favUsers: "")
            let referrance = collection.addDocument(data: advert.toDictionary())

            if (referrance.documentID.isEmpty) {
                self.errorMessage = UploadError.unknowError
                return
            } else {
                await MainActor.run {
                    isDone = true
              adName = ""
                  adCost = 0
                 nameOfBerber = ""
                   imageUrl = ""
                   location = ""
                  errorMessage = UploadError.nothing
                    selectedImage = nil
                  }
          
            }
            }
    func uploadImageData()   async-> Bool{
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5) else {
            errorMessage =  UploadError.invalidImageData
            return false
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        path = "images/\(UUID().uuidString).jpg"
        let imageRef = storageRef.child(path)

        do {
          let _ = try await imageRef.putDataAsync(imageData, metadata: nil)
            print("Image saved")
            
            do {
                let imageURL = try await imageRef.downloadURL()
                path = "\(imageURL)"
                return true
                
            } catch {
                print("ERROR couldNOt get image URl after saving")
                return false
            }
        } catch{
            print("ERROR: uploading image to FirebaseStorage")
            return false
        }
        
      
    }
}

protocol CreateAdvertisementUseCase {
    func createAdvertisement() async -> Void
}


enum UploadError: Error {
    case nothing
    case invalidImageData
    case uploadFailed
    case downloadUrlFailed(Error)
    case unknowError
    case emptyFieldError
}

