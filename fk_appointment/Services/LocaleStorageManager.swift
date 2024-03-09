//
//  LocaleStorageManager.swift
//  fk_appointment
//
//  Created by Furkan on 10.03.2024.
//

import Foundation

struct LocaleStorageManager : LocaleStorageService{
    private let userDefaults = UserDefaults.standard
    
    func save<T>(object: T, forKey key: String) where T : Decodable, T : Encodable {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object){
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    func load<T>(objectType: T.Type, forKey key: String) -> T? where T : Decodable, T : Encodable {
        if let data = userDefaults.object(forKey: key) as? Data {
            let  decoder = JSONDecoder()
            if let object = try? decoder.decode(objectType, from: data) {
                return object
            }
        }
        return nil
    }
    
    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    
}
