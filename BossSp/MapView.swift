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
        Place(name: "British Museum", latitude: 51.519581, longitude: -0.127002),
        Place(name: "Tower of London", latitude: 51.508052, longitude: -0.076035),
        Place(name: "Big Ben", latitude: 51.500710, longitude: -0.124617)
    ]
    @StateObject var locationManager = LocationManager()
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.514134,
            longitude: -0.104236),
        span: MKCoordinateSpan(
            latitudeDelta: 0.075,
            longitudeDelta: 0.075)
    )

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: places){place in
                MapMarker(coordinate: place.coordinate)
            }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea(.all)
            
            HStack {
                LocationButton {
                    locationManager.requestLocation()
                }
                .frame(width: 180, height: 40)
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
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
}


