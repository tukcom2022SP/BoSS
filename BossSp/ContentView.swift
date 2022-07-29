//
//  ContentView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/26.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
                .padding(.vertical,0.1)
            
            MypageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("내정보")
                }
        }
        .accentColor(Color.yellow)
        .onAppear(){
            UITabBar.appearance().backgroundColor = .white
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

