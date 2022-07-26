//
//  Home.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/29.
//

import SwiftUI
import MapKit
import CoreLocation

struct Home: View {
    //@StateObject var mapData = MapViewModel()
    @StateObject var mapData = MapDataModel.shared.mapData
    @State var locationManager = CLLocationManager()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace : MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var AddStoreClick = false
    @State private var homePresenting: Bool = false
    @State private var annotationTitle: String = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                
                MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace,
                        showingPlaceDetails: $showingPlaceDetails, annotations: $locations)
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all, edges: .all)
                    .onTapGesture {
                        AddStoreClick = false
                    }
                    .onAppear{
                        if !homePresenting && annotationTitle != ""{
                            let newLocation = MKPointAnnotation()
                            newLocation.coordinate = self.centerCoordinate
                            newLocation.title = annotationTitle
                            self.locations.append(newLocation)
                        }

                        
                        annotationTitle = ""
                        AddStoreClick = false
                        print("---Home MapView onAppear \(homePresenting)---")
                    }
                
                if AddStoreClick{
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 20, height: 20)
                }
                
                NavigationLink(isActive: $showingPlaceDetails) {
                    StoreInfoView(coordinate: self.selectedPlace?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                } label: {
                    EmptyView()
                }
                VStack{
                    
                    if !AddStoreClick {
                        VStack(spacing: 0) {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                TextField("Search",text: $mapData.searchTxt)
                                    .colorScheme(.light)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(30)
                            
                            if !mapData.places.isEmpty && mapData.searchTxt != ""{
                                ScrollView{
                                    VStack(spacing: 15){
                                        ForEach(mapData.places){ place in
                                            Text(place.place.name ?? "")
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading)
                                                .onTapGesture {
                                                    mapData.selectPlace(place: place)
                                                }
                                            
                                            Divider()
                                        }
                                    }
                                    .padding(.top)
                                }
                              .background(.white)
                                
                            }
                        }.padding()
                    }
                    
                    Spacer()
                    
                    VStack{
                        if AddStoreClick{
                            NavigationLink(
                                destination: AddStoreView(
                                    homePresenting: $homePresenting,
                                    annotationTitle: $annotationTitle,
                                    coordinate: self.centerCoordinate),
                                isActive: $homePresenting) {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(10)
                                        .background(Color.yellow)
                                        .foregroundColor(.black)
                                        .clipShape(Circle())
                                }
                            
                        }else{
                            Button{
                                AddStoreClick = true
                            }label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(10)
                                    .background(Color.yellow)
                                    .foregroundColor(.black)
                                    .clipShape(Circle())
                            }
                        }
                        
                        
                        Button {
                            mapData.focusLocation()
                        } label: {
                            Image(systemName: "location.fill")
                                .font(.title2)
                                .padding(10)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .clipShape(Circle())
                        }
                        
                        Button { // 추가
                            mapData.updateMapType()
                        } label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                .font(.title2)
                                .padding(10)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .clipShape(Circle())
                        }
                        
//                        Button { // 추가
//                            //mapData.updateMapType()
//                            //mapData.addStoreAnnotation()
//                            let newLocation = MKPointAnnotation()
//                            newLocation.coordinate = self.centerCoordinate
//                            newLocation.title = "Test"
//                            newLocation.subtitle = "꾹 눌러 정보 보기"
//                            print("추가 전 \(self.locations.count)")
//                            self.locations.append(newLocation)
//                            print("추가 후 \(self.locations.count)")
//                        } label: {
//                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
//                                .font(.title2)
//                                .padding(10)
//                                .background(Color.yellow)
//                                .foregroundColor(.black)
//                                .clipShape(Circle())
//                        }
                        
//                        Button { // 삭제
//                            //mapData.updateMapType()
//                            //mapData.addStoreAnnotation()
//                            let count = locations.count
//                            self.locations.remove(at: count-1)
//                        } label: {
//                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
//                                .font(.title2)
//                                .padding(10)
//                                .background(Color.yellow)
//                                .foregroundColor(.black)
//                                .clipShape(Circle())
//                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(5)
                }
            }
            .onAppear {
                locationManager.delegate = mapData
                locationManager.requestWhenInUseAuthorization()
            }
            .alert(isPresented: $mapData.permissionDenied) {
                Alert(title: Text("Permission Denied"),
                      message:Text("Please Enable Permission In App Settings"),
                      dismissButton: .default(Text("Goto Settings"),
                        action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    
                }))
            }
            .onChange(of: mapData.searchTxt, perform: { value in
                let delay = 0.3
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    if value == mapData.searchTxt{
                        // Search ...
                        self.mapData.searchQuery()
                    }
                }
            })
            //.navigationBarTitle("")
            .navigationBarHidden(true)
//            .alert(isPresented: $showingPlaceDetails) {
//                Alert(title: Text(selectedPlace?.subtitle ?? "Missing"),
//                      primaryButton: .default(Text("Ok")),
//                      secondaryButton: .default(Text("edit")){
//
//                })
//            }
        }// NavigationView
        .onAppear{
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

