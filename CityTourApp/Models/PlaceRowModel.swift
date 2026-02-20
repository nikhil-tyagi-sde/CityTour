//
//  PlaceRowModel.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 20/02/26.
//

// Google photo API Link: https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=


import Foundation

struct PlaceRowModel: Identifiable { //For display purpose on UI, here want to make adjustments specially for the photos.
    let id: String
    let name: String
    let photoURL: URL
    let rating: Double
    let address: String
    
    init?(place: PlaceDetailResponseModel) {
        self.id = place.placeId
        self.name = place.name
        self.rating = place.rating
        self.address = place.vicinity
        guard let photos = place.photos, //photos is optional, we don't wish to display a place which does not have any photo to display.
              let firstPhoto = photos.first,
        let photoURL = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(firstPhoto.photoReference)&key=AIzaSyA9lSv2GZgEo3NoPhRixnr5qVGe4DB-Xqc") else { //These 2 parts should succeed in order for guard statement to succeed, it failing means that we are unable to fetch the first photo.
            return nil //nil as exit condition signalling that we are unable to fetch the data.
        }
        self.photoURL = photoURL
        print(photoURL)
    }
}


