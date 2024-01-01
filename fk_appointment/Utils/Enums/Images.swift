//
//  Images.swift
//  fk_appointment
//
//  Created by Furkan on 16.10.2023.
//

import Foundation
import SwiftUI

enum Images: String {
    case berber = "img_berber"
    case userAvatar = "user_avatar"
}

struct ImageItems {
    enum Authentication: String {
        case login = "berber_vertical"
    }
}

extension String {
    func image() -> Image {
        return Image(self)
    }
}
