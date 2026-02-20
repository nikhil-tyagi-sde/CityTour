//
//  PlacesViewModel.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 18/02/26.
//

import Foundation
import Combine
import CoreLocation

// 1. Instance CoreLocation Manager.
// 2. Ask the user for location service permissions.
// 3. Core Location manager Delegate.

@MainActor //Swift UI's robust checking that anything related to UI not to happen in background thread, If its a UI element update then it should happen on the Main thread.
class PlacesViewModel: NSObject, ObservableObject {
    private let apiClient = APIClient()
    private let locationManager = CLLocationManager()
    @Published var selectedKeyword: Keyword = .cafe
    @Published var places: [PlaceRowModel] = []
    @Published var isLoading: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var presentAlert: Bool = false
    var currentLocation: CLLocation? //optional, because it can have a value only if user grants the access to the data.
    
    
    // We are asking for location permissions as soon as this viewModel initializes.
    override init() { // as we are inheriting from NSObject which has its own initializer, we need overriding it.
        super.init() // calling init from the super class
        locationManager.delegate = self //delegation manager is aware that where it should update the change of authorization. it should do that using the methods speified over the extension of class.
        locationManager.requestWhenInUseAuthorization() //Permits the location access when user is using the application.
    }
    
    func fetchPlaces(location: CLLocation) async { //This function will be called only at the begining of the app. we hardcoded "coffee" so the first set of the results we see are from fetchPlaces and Coffee
        isLoading = true
        let results = await apiClient.getPlaces(forKeyword: "Coffee", location: location)
        isLoading = false
        parseAPIResult(result: results)
    }
    
    func changeKeyword(to keyword: Keyword) async { //whenever a keyword is changed, we want to fetch the results again, API hit.
        guard let currentLocation = currentLocation else { return } //current location could be 0.
        if selectedKeyword == keyword { //We don't want to make any wasteful API call, only when the location is changed.
            return
        } else {
            selectedKeyword = keyword
        }
        isLoading = true
        let results = await apiClient.getPlaces(forKeyword: keyword.apiName, location: currentLocation)
        isLoading = false
        parseAPIResult(result: results)
    }
    
    func parseAPIResult(result: APIClient.PlacesResult) {
        switch result{
        case .success(let placesResponseModel):
            let places = placesResponseModel.results
            //Below HOF filters out those results which cannot be converted into a row model.
            self.places = places.compactMap({PlaceRowModel(place: $0)})
            
        case .failure(let placesError):
            switch placesError {
            case .invalidURL, .invalidResponse, .badRequestError:
                alertTitle = "Something has gone wrong"
                alertMessage = "We apologize. We are looking into the issue."
            case .serverError:
                alertTitle = "Something has gone wrong"
                alertMessage = "Please check your internet connection or try again later."
            }
            presentAlert = true
        }
    }
}

extension PlacesViewModel: CLLocationManagerDelegate { // Just to report the status of the permission -> Granted or Not.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { //To know what choice user made regarding the permissions grant. returns an enum.
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.requestLocation() // requestLocation will fetch that location. One time location update, not a stream.
        case .denied, .restricted: //restricted - parental access.
            alertTitle = "No Location access"
            alertMessage = "Please grant location access in settings to allow city tour to find the places around you."
            presentAlert = true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization() //Ask for the permission, if not yet asked.
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) { // To handle any errors
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // Why [CLLocation] array? it gets back range of results and then we can triangulate the exact location using it. We do not get just one result, we get back the range of possibilities of where you could be?
        
        guard let location = locations.first else { return } // Fetch the first entry.
        currentLocation = location
        Task {
            await fetchPlaces(location: location)
        }
    }
}
