//
//  CustomDropDown.swift
//  fk_appointment
//
//  Created by Furkan on 3.11.2023.
//

import SwiftUI

struct CustomDropDown: View {
    @Binding var selectedValue: Int
    var values: [PermissionType]
    var onChanges: (Int) -> Void

    var body: some View {
        HStack {
            Text("Kullanıcı Tipi:")
                .padding(.trailing, 10)
            Picker("", selection: $selectedValue) {
                ForEach(values, id: \.self) { value in
                    Text(value.description).tag(value.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedValue, perform: { newValue in
                onChanges(newValue)
            })
        }
        .frame(maxWidth: .infinity, maxHeight:70 )
        
        .padding()
        .border(Color.black)
        .cornerRadius(RadiusItems.radius)
    }
}

enum PermissionType: Int, CaseIterable{
    case defaultUser = 0
    case workerUser = 1
    case bossUser = 2
    
    var description :String {
        switch self {
        case .defaultUser: return "Müşteri"
        case .workerUser: return "Çalışan"
        case .bossUser: return "İş yeri sahibi"
        }
    }
    
}
