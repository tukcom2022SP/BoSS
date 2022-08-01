//
//  MapView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/29.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate : CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @EnvironmentObject var mapData: MapViewModel
    @Binding var annotations: [MKPointAnnotation]
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        init(_ parent: MapView){
            self.parent = parent
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            print("8")
            if annotation.isKind(of: MKUserLocation.self){ return nil } // annotation이 User이면 annotation 표시 X
            else{
                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                //pinAnnotation.tintColor = .red
                //pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                pinAnnotation.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

                return pinAnnotation
            }

        }
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print(view.annotation!.coordinate)
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            print("0")
            // StoreInfoView로 이동하기 위한 절차
            guard let placemark = view.annotation as? MKPointAnnotation else {return}
            parent.selectedPlace = placemark    // MKAnnotation ( title, subtitle, coordinate )
            parent.showingPlaceDetails = true
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
    
    func makeCoordinator() -> Coordinator {
        print("6")

        return MapView.Coordinator(self)
    }
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
//        // 앱 실행하자마자 핀 찍힘
//        let annotaion = MKPointAnnotation()
//        annotaion.coordinate = CLLocationCoordinate2D(latitude: 37, longitude: 128)
//        annotaion.title = "test"
//        view.addAnnotation(annotaion)
        
        print("7")
        
        return view
        
    }
    func updateUIView(_ view: MKMapView, context: Context) {
        print("Updating")
        print("1 \(annotations.count)")
        print("2 \(view.annotations.count)")
        // annotations.count : 변경된 값     view.annotations.count : 변경 이전 값
        if annotations.count == view.annotations.count{
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }else if annotations.count < view.annotations.count{
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
    
    
}


