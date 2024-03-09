//
//  CreateAdvertisementView.swift
//  fk_appointment
//
//  Created by Furkan on 9.11.2023.
//

import SwiftUI
import AlertToast


struct EditAccountView: View {
    
    @ObservedObject private var viewModel = CreateAdvertisementViewModel()
    
    let  iconSize :CGFloat = 22
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (alignment: .leading, spacing: 0){
                    FormFieldLabel(header: "Name")
                    EditTextField(text: $viewModel.adName,width: iconSize, height:iconSize )
                    FormFieldLabel(header: "Surname")
                    EditTextField(text: $viewModel.adName,width: iconSize, height:iconSize )
                    FormFieldLabel(header: "City")
                    EditTextField(text: $viewModel.adName,width: iconSize, height:iconSize )
                    FormFieldLabel(header: "Town")
                    EditTextField(text: $viewModel.adName,width: iconSize, height:iconSize )
                    VStack(alignment: .leading, spacing: 0){
                        FormFieldLabel(header: "Neighborhood")
                        EditTextField(text: $viewModel.adName,width: iconSize, height:iconSize )
                        NormalButton(onTap: {
                            Task {
                                await viewModel.createAdvertisement()
                            }
                        }, title:"Update").padding(.top, PagePadding.All.normal.rawValue)
                    }
                }.toast(isPresenting: $viewModel.isDone){
                    AlertToast(type: .regular, title: "Bilgiler başarı ile değiştirildi!")
                }.padding(.horizontal, PagePadding.Horizontal.normal.rawValue)  .navigationBarTitle(Text(""), displayMode: .inline)
            }  .navigationBarTitle(Text(""), displayMode: .inline)
        }  .navigationBarTitle(Text(""), displayMode: .inline)}

    private func showSnackbar(_ text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            viewModel.isDone = false
        }
    }
    
}
struct FormFieldLabel: View {
    let header: String
    var body:some View {
        Text(header)
            .foregroundColor(Color.black)
            .font(.system(size: 18))
            .disabled(false)
    }
}
