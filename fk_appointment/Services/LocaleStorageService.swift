//
//  LocaleStorageService.swift
//  fk_appointment
//
//  Created by Furkan on 10.03.2024.
//

import Foundation


protocol LocaleStorageService {
    func save<T: Codable>(object: T, forKey key: String)
    func load<T: Codable>(objectType: T.Type, forKey key: String)-> T?
    func removeObject(forKey key: String)
}
