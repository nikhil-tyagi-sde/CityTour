//
//  PlacesViewModel.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 18/02/26.
//

import Foundation
import Combine
import CoreLocation

//1. Instance CoreLocation Manager.
//2. Ask the user for location service permissions.
//3. Core Location manager Delegate.

@MainActor //Swift UI's robust checking that anything related to UI not to happen in background thread, If its a UI element update then it should happen on the Main thread.
class PlacesViewModel: NSObject, ObservableObject {
    private let apiClient = APIClient()
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocation? //optional, because it can have a value only if user grants the access to the data.
    
    // We are asking for location permissions as soon as this viewModel initializes.
    override init() { // as we are inheriting from NSObject which has its own initializer, we need overriding it.
        super.init() // calling init from the super class
        locationManager.delegate = self //delegation manager is aware that where it should update the change of authorization. it should do that using the methods speified over the extension of class.
        locationManager.requestWhenInUseAuthorization() //Permits the location access when user is using the application.
    }
    
    func fetchPlaces(location: CLLocation) async {
        print("DEBUG: latitude \(location.coordinate.latitude) and longitude \(location.coordinate.longitude)")
        await apiClient.getPlaces(forKeyword: "Coffee", location: location)
    }
    
}

extension PlacesViewModel: CLLocationManagerDelegate { //Just to report the status of the permission -> Granted or Not.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { //To know what choice user made regarding the permissions grant. returns an enum.
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location has been approved")
            locationManager.requestLocation() //requestLocation will fetch that location. One time location update, not a stream.
        case .denied:
            print("Location has been denied")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //Why [CLLocation] array? it gets back range of results and then we can triangulate the exact location using it. We do not get just one result, we get back the range of possibilities of where you could be?
        
        guard let location = locations.first else { return } //fetch the first entry.
        currentLocation = location //We store the location to the currentLocation variable.
    }
}
