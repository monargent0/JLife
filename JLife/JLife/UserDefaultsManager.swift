//
//  UserDefaultsManager.swift
//  JLife
//
//  Created by OoO on 6/4/24.
//

import Foundation

struct UserDefaultsManager<T> {
  
  let key: String
  
  init(key: String) {
    self.key = key
  }
  
  func getUserDefaultsValue() -> T? {
    UserDefaults.standard.value(forKey: key) as? T
  }
  
  func setUserDefaultsValue(with value: T) {
    UserDefaults.standard.setValue(value, forKey: key)
  }
}
