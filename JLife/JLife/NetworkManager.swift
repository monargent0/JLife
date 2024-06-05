//
//  NetworkManager.swift
//  JLife
//
//  Created by OoO on 6/5/24.
//

import Foundation
import CoreLocation
import UIKit

final class NetworkManager {
  func requestData<T: Decodable>(url: URL, query: [String: String]? = nil, objectType: T.Type, handler: @escaping (Result<T, Error>) -> Void) {
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    components?.queryItems = query?.map { URLQueryItem(name: $0, value: $1) }
    
    var request = URLRequest(url: components?.url ?? url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error {
        handler(.failure(error))
        print("데이터 로딩 실패")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        guard let error else { return }
        handler(.failure(error))
        print("데이터 응답 실패")
        return
      }
      
      if let data {
        let jsonDecoder = JSONDecoder()
        do {
          let result: T = try jsonDecoder.decode(T.self, from: data)
          handler(.success(result))
        } catch {
          handler(.failure(error))
        }
      }
    }.resume()
  }
  
  func loadWeatherPhenomena(handler: @escaping (Result<WeatherInformation, Error>) -> Void, lat: String, lon: String) {
    var component = URLComponents()
    component.scheme = OpenWeather.scheme.description
    component.host = OpenWeather.host.description
    component.path = OpenWeather.phenomenaPath.description
    
    let query: [String: String] = [
      "lat": String(lat),
      "lon": String(lon),
      "appid": Bundle.main.weatherAPIKey
    ]
    
    guard let url = component.url else { return }
    
    requestData(url: url, query: query, objectType: WeatherInformation.self) { result in
      switch result {
      case .success(let data):
        handler(.success(data))
      case .failure(let error):
        handler(.failure(error))
      }
    }
  }
}
