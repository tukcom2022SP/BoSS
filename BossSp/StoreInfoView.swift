//
//  ShowStoreInfoView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/29.
//

import SwiftUI
import FirebaseFirestore

var g_storeAddress = ""
var g_storeName = ""
var g_storeType = ""
var g_storeDayOff = ""
var g_storeDescription = ""

func FindData() { // 파이어베이스 데이터 조회
    let db = Firestore.firestore() // 파이어베이스 인스턴스 초기화
    let ref = db.collection("stores").document("store1")
    

    ref.addSnapshotListener { (snapshot, error) in
        if error == nil {
            
            if let address = snapshot?.get("storeAddress") as? String {
                g_storeAddress = address
            }
            
            if let name = snapshot?.get("storeName") as? String {
                g_storeName = name
            }
            
            if let type = snapshot?.get("storeType") as? String {
                g_storeType = type
            }
            
            if let dayOff = snapshot?.get("storeDayOff") as? String {
                g_storeDayOff = dayOff
            }
            
            if let desc = snapshot?.get("storeDescription") as? String {
                g_storeDescription = desc
            }
            
        }
    }
}

struct StoreInfoView: View {
    
    @State private var storeAddress = "" // 맛집 주소
    @State private var storeName = "" // 맛집 이름
    @State private var storeType = "" // 맛집 종류
    @State private var storeDayOff = "" // 맛집 휴무일
    @State private var storeDescription = "" // 맛집 설명
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    Text("\(storeType)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                    
                    Text("\(storeName)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.black)

                    Text("\(storeAddress)")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .center, spacing: 20) {
                            VStack {
                                Image("")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                            }
                            VStack {
                                Image("")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                            }
                            VStack {
                                Image("")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                            }
                        }.padding()
                    } // ScrollView
                    
                    Text("\(storeDescription)")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .frame(width: 300, height: 300)
                    
                    HStack {
                        Text("휴무 ")
                        
                        Text("\(storeDayOff)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.gray)
                    }
                    
                    Button("조회") {
                        FindData()
                        self.storeAddress = g_storeAddress // 맛집 주소
                        self.storeName = g_storeName // 맛집 이름
                        self.storeType = g_storeType // 맛집 종류
                        self.storeDayOff = g_storeDayOff // 맛집 휴무일
                        self.storeDescription = g_storeDescription // 맛집 설명
                    }.padding()
                } //VStack
            } // ScrollView
        } // NavigationView
    } // body
} // StoreInfoView


struct StoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoreInfoView()
            .previewInterfaceOrientation(.portrait)
    }
}

        
