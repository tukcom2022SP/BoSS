//
//  ContentView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var mapAPI = MapAPI()
    @State private var text = ""
    
    var body: some View {

//        VStack{ 지역 검색 부분
//            TextField("주소를 입력하세요",text: $text)
//                .textFieldStyle(.roundedBorder)
//                .padding(.horizontal)
//
//            Button("주소 검색"){
//                mapAPI.getLocation(address: text, delta: 0.5)
//            }
//            Map(coordinateRegion: $mapAPI.region,annotationItems: mapAPI.locations){location in
//                MapMarker(coordinate: location.coordinate, tint: .blue) 지오코딩 api사용 -map model
//            }
//            .ignoresSafeArea()
//        }

        TabView{
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
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

