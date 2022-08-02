//
//  MapViewModel.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/29.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{

    @Published var mapView = MKMapView()
    
    // Region
    @Published var region: MKCoordinateRegion!
    // Alert
    @Published var permissionDenied = false
    
    // Map Type
    @Published var mapType : MKMapType = .standard
    
    // SearchText
    @Published var searchTxt = ""
    
    // Searched Places
    @Published var places : [Place] = []
    
    
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }else{
            mapType = .standard
            mapView.mapType = mapType
        }
        
        print("5")
    }
    
    func focusLocation(){
        guard let _ = region else{return}
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        print("4")
    }
    
    // Search Places.. 
    
    func searchQuery(){
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        MKLocalSearch(request: request).start { response, _ in
            guard let result = response else { return }
            self.places = result.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    func getCenterCoordinate() -> CLLocationCoordinate2D {
        return mapView.centerCoordinate
    }
    
    // AddStoreAnnotation Beta
    func addStoreAnnotation(){
        // 특정 위치에 핀 추가
        let annotaion = MKPointAnnotation()
        let center = mapView.centerCoordinate
//        annotaion.coordinate = CLLocationCoordinate2D(latitude: 37, longitude: 128)
        annotaion.coordinate = center
        annotaion.title = "test"
        
        mapView.addAnnotation(annotaion)
        
        
        // 핀 위치로 이동
        let coordinateRegion = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    // Pick Search Result
    func selectPlace(place: Place){
        searchTxt = ""
        guard let coordinate = place.place.location?.coordinate else { return }
        
//         Annotation 표시
//        let pointAnnotation = MKPointAnnotation()
//        pointAnnotation.coordinate = coordinate
//        pointAnnotation.title = place.place.name ?? "No Name"
//
//
//        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000,
        longitudinalMeters: 1000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
        
        print("---locationManagerDidChangeAuthorization (내위치허용)---")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
        
        print("2")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        guard let location = locations.last else { return }
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        //self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666, longitude: 126.9784), latitudinalMeters: 100, longitudinalMeters: 100)
        self.mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        print("---locationManager didUpdateLocations---")
    }

}
