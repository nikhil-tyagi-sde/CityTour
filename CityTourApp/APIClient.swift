//
//  APIClient.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 18/02/26.
//

import Foundation
import CoreLocation

//CLLocation - access to latitude and longitude

class APIClient {
    private let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    private let googlePlacesKey = "AIzaSyA9lSv2GZgEo3NoPhRixnr5qVGe4DB-Xqc"
    
    private func responseType(statusCode: Int) -> ResponseType {
        // 200-299 = ok
        // 400-499 = bad request
        // 500-599 = server error
        switch statusCode {
        case 100..<200:
            print("Informational")
            return .informational
        case 200..<300:
            print("DEBUG: Successful request")
            return .success
        case 300..<400:
            print("DEBUG: Redirectional")
            return .redirection
        case 400..<500:
            print("DEBUG: Bad Request")
            return .clientError
        case 500..<600:
            print("DEBUG: Server Error")
            return .serverError
        default:
            return .undefined
        }
    }
    
    //location
    //radius
    //Keyword
    //rank by, radius cannot be used in this case.
    
    func getPlaces(forKeyword keyword: String, location: CLLocation) async { //externally while calling thisfunc we used parm name as "forKeyword" and internally inside the func we call it "keyword".
        guard let url = createURL(location: location, keyword: keyword) else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                return
            }
            let responseType = responseType(statusCode: response.statusCode)
            switch responseType {
            case .informational, .redirection, .clientError, .serverError, .undefined:
                print("Error occurred")
            case .success:
                let decodedJson = try JSONDecoder().decode(PlacesResponseModel.self, from: data)
                print(decodedJson)
            }
            
//            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {//attempt to cast as dict
//                return
//            }
//            print(json)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createURL(location: CLLocation, keyword: String) -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "location", value: String(location.coordinate.latitude) + "," + String(location.coordinate.longitude)),
            URLQueryItem(name: "rankby", value: "distance"),
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "key", value: googlePlacesKey)
        ]
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
