//
//  FirebaseView.swift
//  fk_appointment
//
//  Created by Furkan on 9.12.2023.
//

import SwiftUI


struct FirebaseImage : View {
    let placeholder = UIImage(named: "berber_vertical.png")!


    init(id: String) {
        self.imageLoader = Loader(id)
    }

    @Published private var imageLoader : Loader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)

    }
}
