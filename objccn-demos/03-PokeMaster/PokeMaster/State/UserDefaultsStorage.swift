//
//  UserDefaultsStorage.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefaultsStorage<T> {
    var value: T
    var defaultValue: T
    
    var key: String
    
    init(key: String, defaultValue: T) {
        if defaultValue is AppState.Settings.Sorting {
            if let rawValue = UserDefaults.standard.value(forKey: key) as? String {
                value = AppState.Settings.Sorting(rawValue: rawValue) as? T ?? defaultValue
            } else {
                value = defaultValue
            }
        } else {
            value = UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        set {
            value = newValue

            if let sort = newValue as? AppState.Settings.Sorting {
                UserDefaults.standard.set(sort.rawValue, forKey: key)
            } else {
                UserDefaults.standard.set(value, forKey: key)
            }
        }
        
        get {
            if let sort = value as? AppState.Settings.Sorting {
                return AppState.Settings.Sorting(rawValue: sort.rawValue) as? T ?? defaultValue
            } else {
                return value
            }
        }
    }
}
