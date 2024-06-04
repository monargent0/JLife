//
//  Bundle+.swift
//  JLife
//
//  Created by OoO on 6/5/24.
//

import Foundation

extension Bundle {
  
  var weatherAPIKey: String {
    guard let file = self.path(forResource: "WeatherAPIKey", ofType: "plist") else { return "" }
    
    guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
    
    guard let key = resource[Preference.Bundle.weatherAPI.key] as? String else {
      fatalError("""
            Failed to load the WeatherAPIKey.
            Make sure the WeatherAPIKey file is included in the project and the file name is spelled correctly.
            """
      )
    }
    return key
  }
}
