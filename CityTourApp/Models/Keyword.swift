//
//  Keyword.swift
//  CityTour
//
//

import Foundation
// CaseIterable - we can convert this enum to array of cases.
// Codable - we can encode and decode this as well.
// Identifiable - Each case is unique, so that we can use an each case as a unique ID in itself. Hence the keyword.
enum Keyword : Identifiable, CaseIterable, Codable {
    
    case cafe,
         gym,
         beauty_salon,
         food,
         burger,
         pizza,
         sushi,
         doctor,
         gas_station,
         florist,
         tourist_attraction,
         car_wash,
         supermarket,
         dentist,
         department_store,
         electronics_store,
         bank,
         hair_care,
         hospital,
         mosque,
         museum,
         parking,
         pharmacy,
         real_estate_agency,
         shopping_mall,
         spa,
         car_rental,
         car_repair,
         stadium
    
    var id : Self {
        return self
    }
    
    var title : String {
        switch self {
        case .cafe:
            return "Coffee Shops"
        case .burger:
            return "Burgers"
        case .pizza:
            return "Pizza"
        case .sushi:
            return "Sushi"
        case .food:
            return "Restaurant"
        case .gym:
            return "Gym"
        case .bank:
            return "Bank"
        case .beauty_salon:
            return "Beauty Salon"
        case .car_rental:
            return "Car Rental"
        case .car_repair:
            return "Car Repair"
        case .car_wash:
            return "Car Wash"
        case .dentist:
            return "Dentist"
        case .department_store:
            return "Department Shop"
        case .doctor:
            return "Doctor"
        case .electronics_store:
            return "Electronic Store"
        case .florist:
            return "Flowers"
        case .gas_station:
            return "Petrol Station"
        case .hair_care:
            return "Barber"
        case .hospital:
            return "Hospital"
        case .mosque:
            return "Mosque"
        case .museum:
            return "Museum"
        case .parking:
            return "Parking"
        case .pharmacy:
            return "Pharmacy"
        case .real_estate_agency:
            return "Real Estate"
        case .shopping_mall:
            return "Shopping Mall"
        case .spa:
            return "SPA"
        case .stadium:
            return "Stadium"
        case .supermarket:
            return "Super market"
        case .tourist_attraction:
            return "Tourist Attraction"
        }
    }
    
    var apiName : String { //What we query to google for appropriate results.
        switch self {
        case .cafe:
            return "Coffee"
        case .food:
            return "Restaurants"
        case .burger:
            return "Burger"
        case .pizza:
            return "Pizza"
        case .sushi:
            return "Sushi"
        case .gym:
            return "Gym"
        case .bank:
            return "Bank OR ATM"
        case .beauty_salon:
            return "Beauty salon"
        case .car_rental:
            return "Rent a car OR Car Rental"
        case .car_repair:
            return "Car repair"
        case .car_wash:
            return "Car wash"
        case .dentist:
            return "Dentist OR Dental clinic"
        case .department_store:
            return "Department store"
        case .doctor:
            return "Doctor "
        case .electronics_store:
            return "Electronics store OR Electronics"
        case .florist:
            return "Florist OR Flowers"
        case .gas_station:
            return "Petrol Station OR Gas Station"
        case .hair_care:
            return "Haircut"
        case .hospital:
            return "Hospital OR Medical Clinic "
        case .mosque:
            return "Mosque OR Masjid"
        case .museum:
            return "Museum OR Place of interest"
        case .parking:
            return "Parking OR Paid parking"
        case .pharmacy:
            return "Pharmacy OR Drug store"
        case .real_estate_agency:
            return "Real Estate OR Rental Agency company"
        case .shopping_mall:
            return "Shopping mall OR Mall"
        case .spa:
            return "SPA OR Wellness"
        case .stadium:
            return "Rental Fields OR Stadium"
        case .supermarket:
            return "Convenience store OR Supermarkets"
        case .tourist_attraction:
            return "Tourist attraction"
            
        }
    }
    
}
