//
//  ContentView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/26.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection){
            Home()
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
                .padding(.vertical,0.1)
                .tag(1)
            
            StoreListView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("맛집 리스트")
                }
                .tag(2)
            
            MypageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("내정보")
                }
                .tag(3)
        }
        .accentColor(Color.yellow)
        .onAppear(){
            UITabBar.appearance().backgroundColor = .white
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

