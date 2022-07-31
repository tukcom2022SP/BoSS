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
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    @State var AddStoreClick = false
    var body: some View {
        NavigationView{
            ZStack{
                MapView()
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all, edges: .all)
                    .onTapGesture {
                        //mapData.updateMapType()
                        AddStoreClick = false
                    }
                
                if AddStoreClick{
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 20, height: 20)
                }
                
                
                VStack{
                    
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
                    
                    Spacer()
                    
                    VStack{
                        if AddStoreClick{
                            NavigationLink{
                                AddStoreView(coordinate: mapData.getCenterCoordinate())
                            }label: {
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
                        
                        Button {
                            //mapData.updateMapType()
                            mapData.addStoreAnnotation()
                        } label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                .font(.title2)
                                .padding(10)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .clipShape(Circle())
                        }
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
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
