//
//  HInputField.swift
//  fk_appointment
//
//  Created by Furkan on 31.10.2023.
//

import SwiftUI

struct HTextIconField: View {
   let hint: LocalizedStringKey
   let iconName: String
   var text: Binding<String>
    let width: CGFloat?
    let height: CGFloat?
    init(hint: LocalizedStringKey, iconName: String, text: Binding<String>, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.hint = hint
        self.iconName = iconName
        self.text = text
        self.width = width
        self.height = height
    }
   var body: some View {
       HStack {
           iconName.image().resizable().frame(width: width, height: height)
           TextField(hint, text: text).foregroundColor(.black)
       }.modifier(TextFieldModifier())
   }
}

struct HTextSecureIconField: View {
   let hint: LocalizedStringKey
   let iconName: String
   var text: Binding<String>
   var body: some View {
       HStack {
           iconName.image()
           SecureField(hint, text: text ).foregroundColor(.black)
       }.modifier(TextFieldModifier())
   }
}
struct HTIntInputView: View {
   let hint: LocalizedStringKey
   let iconName: String
   var value: Binding<Double>
    let width: CGFloat?
    let height: CGFloat?
   var body: some View {
       HStack {
           iconName.image().resizable().frame(width: width, height: height)
           TextField(hint, value: value , formatter: NumberFormatter()).foregroundColor(.black) .keyboardType(.numberPad)
       }.modifier(TextFieldModifier())
   }
}

