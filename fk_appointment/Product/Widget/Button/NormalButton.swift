//
//  NormalButton.swift
//  fk_appointment
//
//  Created by Furkan on 27.10.2023.
//

import SwiftUI

struct NormalButton: View {
    var onTap: () -> Void
    var title: String
    var body: some View{
        Button {
            onTap()
        } label: {
            HStack {
                Spacer()
                Text(title.locale())
                Spacer()
            } .tint(.white)
                .font(.system(size: FontSizes.headline, weight: .semibold)).padding(.all, PagePadding.All.normal.rawValue)
        }.buttonBorderShape(.roundedRectangle)
            .controlSize(.large)
            .background(Color.peach)
            .cornerRadius(RadiusItems.radius)
    }
}


