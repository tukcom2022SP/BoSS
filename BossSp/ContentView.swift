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
        VStack{
            TextField("주소를 입력하세요",text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("주소 검색"){
                mapAPI.getLocation(address: text, delta: 0.5)
            }
            Map(coordinateRegion: $mapAPI.region,annotationItems: mapAPI.locations){location in
                MapMarker(coordinate: location.coordinate, tint: .blue)
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

