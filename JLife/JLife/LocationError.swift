//
//  LocationError.swift
//  JLife
//
//  Created by OoO on 6/5/24.
//

enum LocationError: Error {
  case locationUnknown
  case denied
  case otherCLError
  case unknown
  
  var description: String {
    switch self {
    case .locationUnknown:
      "Unknown Location"
    case .denied:
      "Request Location is Denied"
    case .otherCLError:
      "other Core Location error"
    case .unknown:
      "Unknown Error"
    }
  }
}
