//
//  CreateAdvertisementView.swift
//  fk_appointment
//
//  Created by Furkan on 9.11.2023.
//

import SwiftUI
import AlertToast


struct CreateAdvertisementView: View {
    
    @ObservedObject private var viewModel = CreateAdvertisementViewModel()
   
    let  iconSize :CGFloat = 22
    
    var body: some View {
        NavigationView{
            ScrollView{
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                                  .progressViewStyle(CircularProgressViewStyle())
                }
                
                
                CustomImagePicker(selectedImage: $viewModel.selectedImage)
                HTextIconField(hint: LocaleKeys.General.adHint.rawValue.locale(),iconName: IconItems.edit, text: $viewModel.adName,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                
                  HTextIconField(hint: LocaleKeys.General.locationHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.location,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                
                  HTextIconField(hint: LocaleKeys.General.nameOfBerberHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.nameOfBerber,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                
                HTIntInputView(hint: LocaleKeys.General.costHint.rawValue.locale(), iconName: IconItems.edit, value: $viewModel.adCost , width: iconSize, height:iconSize).padding(.top, PagePadding.All.normal.rawValue)
                NormalButton(onTap: {
                    Task {
                           await viewModel.createAdvertisement()
                        }
                    
                }, title: LocaleKeys.TabView.create.rawValue).padding(.top, PagePadding.All.normal.rawValue)
                
            }.toast(isPresenting: $viewModel.isDone){
                
               
                AlertToast(type: .regular, title: "Başarı ile Oluşturuldu!")
                
            }.navigationBarTitleDisplayMode(.inline).navigationBarTitle("Create Ad").padding(.horizontal, PagePadding.Horizontal.normal.rawValue)
            }
        }}
    
    
    private func showSnackbar(_ text: String) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.isDone = false
            }
        }

}
