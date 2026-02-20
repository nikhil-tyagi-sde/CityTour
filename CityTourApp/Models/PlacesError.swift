//
//  PlacesError.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 19/02/26.
//

import Foundation

enum PlacesError: Error {
    case invalidURL, invalidResponse, badRequestError, serverError
}
