//
//  ViewStatusHiddenModifier.swift
//  fk_appointment
//
//  Created by Furkan on 3.11.2023.
//

import Foundation
import SwiftUI

struct ViewStatusHiddenModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.toolbar {
                ToolbarItem(placement: .automatic) {
                    EmptyView()
                }
            }
        } else {
            content.navigationBarHidden(true)
        }
    }
}
