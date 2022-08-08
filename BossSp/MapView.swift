//
//  MapView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/29.
//

import SwiftUI
import MapKit
import FirebaseFirestore

struct MapView: UIViewRepresentable {
    @ObservedObject var storeModel = StoreModel.shared
    
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
            print("---mapView viewFor (내위치 annotation)---")
            if annotation.isKind(of: MKUserLocation.self){ return nil } // annotation이 User이면 annotation 표시 X
            else{
                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")

                //pinAnnotation.tintColor = .red
                //pinAnnotation.animatesDrop = true
                //pinAnnotation.canShowCallout = true
                //pinAnnotation.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
                return pinAnnotation
            }

        }
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("didSelect")
            
            // 핀 클릭 시 ShowCallout 보임
            //print(view.annotation!.coordinate)
            
            // 핀 클릭 시 바로 StoreInfoView로 이동
            guard let placemark = view.annotation as? MKPointAnnotation else {return}
            parent.selectedPlace = placemark    // MKAnnotation ( title, subtitle, coordinate )
            parent.showingPlaceDetails = true
        }
        
//          // Callout tap시 StoreInfoView로 이동
//        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//            print("0")
//            // StoreInfoView로 이동하기 위한 절차
//            guard let placemark = view.annotation as? MKPointAnnotation else {return}
//            parent.selectedPlace = placemark    // MKAnnotation ( title, subtitle, coordinate )
//            parent.showingPlaceDetails = true
//
//        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
    
    func makeCoordinator() -> Coordinator {
        print("---makeCoordinator---")
        
        return MapView.Coordinator(self)
    }
    func makeUIView(context: Context) -> MKMapView {
        print("---makeUIView---")
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
//        // 앱 실행하자마자 핀 찍힘
//        let annotaion = MKPointAnnotation()
//        annotaion.coordinate = CLLocationCoordinate2D(latitude: 37, longitude: 128)
//        annotaion.title = "test"
//        view.addAnnotation(annotaion)

        let db = Firestore.firestore()
        db.collection("stores").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                    print("Error getting documents: \(err)")
            } else {
                storeModel.stores.removeAll()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let lat = document.get("storeLatitude") as? String
                    let long = document.get("storeLongitude") as? String
                    let mk = MKPointAnnotation()
                    mk.coordinate = CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(long!)!)
                    mk.title = (document.get("storeName") as! String)
                    //mk.subtitle = "꾹 눌러 정보 보기"
                    view.addAnnotation(mk)
                    annotations.append(mk)
                
                    storeModel.stores.append((strName: document.get("storeName") as! String,
                                               strAddress: document.get("storeAddress") as! String,
                                               strDescript: document.get("storeDescription") as! String,
                                               strType: document.get("storeType") as! String))
                }
            }
        }
        
        
        return view
        
    }
    func updateUIView(_ view: MKMapView, context: Context) {
        print("---updateUIView---")
        print("location \(annotations.count)")
        print("view.annotation 전 \(view.annotations.count)")
        // annotations.count : 변경된 값     view.annotations.count : 변경 이전 값
        if annotations.count >= view.annotations.count{
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }else if annotations.count < view.annotations.count{
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
        print("view.annotation 후 \(view.annotations.count)")
        
    }
    
    
}

