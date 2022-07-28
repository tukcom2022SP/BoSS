//
//  ContentView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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

