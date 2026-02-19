//
//  PlacesResponseModel.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 18/02/26.
//

import Foundation

struct PlacesResponseModel : Decodable {
    let results: [PlaceDetailResponseModel]
}

struct PlaceDetailResponseModel: Decodable {
    let placeId: String //If we wish to avoid this casing and use camel case like convention we can use codable enum.
    let name: String
    let rating: Double
    let vicinity: String
    let photos: [PhotoInfo]? //Optional, sometimes photos might not be available.
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case name
        case rating
        case vicinity
        case photos
    }
}

struct PhotoInfo: Decodable {
    let photoReference: String //these names should be exactly same as the keys of API results else data fetch will fail.
    
    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}
