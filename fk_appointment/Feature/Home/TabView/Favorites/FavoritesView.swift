//
//  LoginView.swift
//  fk_appointment
//
//  Created by Furkan on 16.10.2023.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    
    var body: some View {
        
        
        NavigationView{
            if(viewModel.isLoading) {
                ProgressView ().navigationBarTitleDisplayMode(.inline).navigationBarTitle("Favorites")
            }else {
                List(viewModel.advertisements) {  product in
                    HStack{
                        Spacer()
                        ProductCard(product: product, toggleFunction: {
                            viewModel.toggleFav(for: product)
                        })
                        Spacer()
                    }
                    
                } .background(Color.clear) .navigationBarTitleDisplayMode(.inline).navigationBarTitle("Favorites")
            }
            
        }.onAppear{
            viewModel.fetchUserFavoritesAdvertisements()
            
        } .padding(.vertical,0).listStyle(.plain).navigationBarHidden(true)
        
    }
    
}


