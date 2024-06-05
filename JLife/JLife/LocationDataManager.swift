//
//  LocationDataManager.swift
//  JLife
//
//  Created by OoO on 6/5/24.
//

import CoreLocation

class LocationDataManager: NSObject, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  var lat: CLLocationDegrees?
  var lon: CLLocationDegrees?
  
  override init() {
    super.init()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
  }
  
  func start() {
    locationManager.requestLocation()
    
    lat = locationManager.location?.coordinate.latitude
    lon = locationManager.location?.coordinate.longitude
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let locationError = error as? CLError {
      switch locationError.code {
      case CLError.locationUnknown:
        print(LocationError.locationUnknown.description)
      case CLError.denied:
        print(LocationError.denied.description)
        locationManager.stopUpdatingLocation()
      default:
        print(LocationError.otherCLError.description)
      }
    } else {
      print(LocationError.unknown.description)
    }
  }
}
