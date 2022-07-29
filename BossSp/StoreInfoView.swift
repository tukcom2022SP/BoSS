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
            VStack{
                Form{
                    Section(header: Text("주소") // 주소 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Text("\(storeAddress)")
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("맛집 이름") // 맛집 이름 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Text("\(storeName)")
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("음식 종류") // 음식 종류 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Text("\(storeType)")
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("휴무일") // 음식 종류 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Text("\(storeDayOff)")
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    
                    Section(header: Text("설명") // 설명 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Text("\(storeDescription)")
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    
                    
                    Button {
                        FindData()
                        
                        self.storeAddress = g_storeAddress // 맛집 주소
                        self.storeName = g_storeName // 맛집 이름
                        self.storeType = g_storeType // 맛집 종류
                        self.storeDayOff = g_storeDayOff // 맛집 휴무일
                        self.storeDescription = g_storeDescription // 맛집 설명
                        
                        
                    } label: { Text("조회")}
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

                } // Form
            } // VStack
            .navigationBarTitle("맛집 정보")
        } // NavigationView
    } // body
} // AddStoreView


struct StoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoreInfoView()
            .previewInterfaceOrientation(.portrait)
    }
}
