//
//  ContentView.swift
//  CityTourApp
//
//  Created by Nikhil Tyagi on 18/02/26.
//

import SwiftUI

struct PlacesView: View {
    @State private var viewModel = PlacesViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task { //it creates a context that supports concurrency.
//            await apiClient.getPlaces(forKeyword: "Coffee", latitude: 28.37755825417844, longitude: 79.44483114535231)
        }
    }
}

#Preview {
    PlacesView()
}
