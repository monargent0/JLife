//
//  OpenWeather.swift
//  JLife
//
//  Created by OoO on 6/5/24.
//

enum OpenWeather {
  case scheme
  case host
  case phenomenaPath
  case iconURL
  
  var description: String {
    switch self {
    case .scheme:
      "https"
    case .host:
      "api.openweathermap.org"
    case .phenomenaPath:
      "/data/2.5/weather"
    case .iconURL:
      "https://openweathermap.org/img/wn/"
    }
  }
}
