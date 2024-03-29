//
//  TextFieldModifier.swift
//  fk_appointment
//
//  Created by Furkan on 26.10.2023.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2)).foregroundColor(Color.carl)
    }
}

