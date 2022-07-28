//
//  MapView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/27.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View {
    let places = [
        Place(name: "British Museum", latitude: 37.541, longitude: 126.853),
        Place(name: "Tower of London", latitude: 34.531, longitude: 143.435),
        Place(name: "Big Ben", latitude: 36.431, longitude: 142.543)
    ]
//    let places1 = [
//        Place(name: "Apple park", coordinate: CLLocationCoordinate2D(latitude: 37.541, longitude: 126.986))
//    ]
    @StateObject var locationManager = LocationManager()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
//            Map(coordinateRegion: $locationManager.region,
//                showsUserLocation: true,
//                annotationItems: places1, annotationContent: { place in
//                MapAnnotation(coordinate: place.coordinate) {
//
//                }
//            })
            Map(coordinateRegion: $locationManager.region,
                            showsUserLocation: true,
                            annotationItems: places){ place in
                            MapMarker(coordinate: place.coordinate, tint: Color.blue)
                        }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea(.all)

            HStack(alignment: .lastTextBaseline) {
                LocationButton {
                    locationManager.requestLocation()
                }
                .frame(width: 40, height: 40)
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.black)
                .padding(30)
                .labelStyle(.iconOnly)
                .tint(.white)
                
            }
        }
        
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


struct Place : Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
//    var coordinate: CLLocationCoordinate2D
}


