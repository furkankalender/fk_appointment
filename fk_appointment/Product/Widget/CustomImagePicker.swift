//
//  CustomImagePicker.swift
//  fk_appointment
//
//  Created by Furkan on 10.11.2023.
//

import Foundation
import SwiftUI

struct CustomImagePicker: View {
    @Binding  var selectedImage: UIImage?
    @State private  var imageURL: URL?
    @State private var isImagePickerPresented: Bool = false
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300 , height: 200)
            }  else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        isImagePickerPresented.toggle()
                    }
                }
                
        }.sheet(isPresented: $isImagePickerPresented){
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}


