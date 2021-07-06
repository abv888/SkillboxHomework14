//
//  UserDefaultsPesistanceContainer.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import Foundation

struct UDKeys {
    static let nameKey = "UserDefaultsPersistance.nameKey"
    static let surnameKey = "UserDefaultsPersistance.surnameKey"
}

class  UserDefaultsPersistance {
    
    static let shared = UserDefaultsPersistance()
    
    var nameUD: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UDKeys.nameKey)
        }
        get {
            return UserDefaults.standard.string(forKey: UDKeys.nameKey)
        }
    }
    
    var surnameUD: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UDKeys.surnameKey)
        }
        get {
            return UserDefaults.standard.string(forKey: UDKeys.surnameKey)
        }
    }
    
}
