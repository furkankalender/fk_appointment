//
//  LoginView.swift
//  fk_appointment
//
//  Created by Furkan on 16.10.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    
    var body: some View {
        
        
        NavigationView{
            if(viewModel.isLoading) {
                ProgressView ().navigationBarTitleDisplayMode(.inline).navigationBarTitle("Berberler")
            }else {
                List(viewModel.advertisements) {  product in
                    HStack{
                        Spacer()
                        ProductCard(product: product, toggleFunction: {
                            viewModel.toggleFav(for: product)
                        })
                        Spacer()
                    }
                    
                } .background(Color.clear) .navigationBarTitleDisplayMode(.inline).navigationBarTitle("Berberler")
            }
            
        }.onAppear{
            viewModel.fetchAdvertisements()
            
        } .padding(.vertical,0).listStyle(.plain).navigationBarHidden(true)
        
    }}
struct ProductCard: View {
    var product: Advertisement
    var toggleFunction: () -> Void
    
    var body: some View {
        VStack {
            if product.imageURL != nil {
                RemoteImage(url: product.imageURL!)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width - 50, height: 150)
                
            }
            Text(product.name ?? "")
                .font(.title)
                .padding(.top, 1)
            
            Text("Lokasyon: \(product.location ?? "")")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 1)
            
            HStack {
              Spacer()
                Spacer()
                Text(String("\(product.cost ?? 0) TL"))
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top,
                    1)
                Spacer()
              
                    
                Image(systemName: (product.isFav() ) ? "heart.fill" : "heart")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    
                        .scaleEffect(0.8)
                        .onTapGesture {
                            toggleFunction()
                            print("İkon tıklandı!")
                        }
                        .padding(.trailing, 20)
                
            }
            Spacer()        }
        
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        
        
    }
}

struct RemoteImage: View {
    @StateObject private var imageLoader = ImageLoader()
    var url: URL
    
    var body: some View {
        Image(uiImage: imageLoader.image)
            .resizable()
            .scaledToFill()
            .padding(PagePadding.All.normal.rawValue)
        
            .frame(height: 150)
            .onAppear {
                imageLoader.loadImage(url)
            }
    }
}

class ImageLoader: ObservableObject {
    @Published var image = UIImage()
    
    func loadImage(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
    }
}
