//
//  ShowStoreInfoView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/29.
//

import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

struct StoreInfoView: View {
    
    @State private var storeAddress = "" // 맛집 주소
    @State private var storeName = "" // 맛집 이름
    @State private var storeType = "" // 맛집 종류
    @State private var storeDayOff = "" // 맛집 휴무일
    @State private var storeDescription = "" // 맛집 설명
    @State private var images : [Image] = [Image(""), Image(""), Image("")] // 맛집 이미지
    
    var coordinate : CLLocationCoordinate2D
    
    func FindData() { // 파이어베이스 데이터 조회 함수
        let db = Firestore.firestore() // 파이어베이스 인스턴스 초기화
        let ref = db.collection("stores") // 컬렉션 참조
        let storage = Storage.storage() // 파이어스토리지 인스턴스 초기화
        let storageRef = storage.reference() // 스토리지 참조

        ref.whereField("storeLatitude", isEqualTo: String(coordinate.latitude)) // 위도값
            .whereField("storeLongitude", isEqualTo: String(coordinate.longitude)) // 경도값
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        var docName = document.documentID
                        for num in 1...3 {
                            let imgRef = storageRef.child("\(docName)/img\(num).jpg") // 이미지 참조
                            imgRef.downloadURL { (url, error) in // url 다운로드
                                if let url = url{
                                    let data = NSData(contentsOf: url) // url -> 데이터
                                    let image = UIImage(data: data! as Data) // 데이터 -> UI이미지
                                    images[num-1] = Image(uiImage: image!)
                                }
                            }
                        }
                        if let address = document.get("storeAddress") as? String { // 맛집 주소
                            storeAddress = address
                        }
                        if let name = document.get("storeName") as? String { // 맛집 이름
                            storeName = name
                        }
                        if let type = document.get("storeType") as? String {// 맛집 타입
                            storeType = type
                        }
                        if let dayOff = document.get("storeDayOff") as? String { // 맛집 휴무일
                            storeDayOff = dayOff
                        }
                        if let desc = document.get("storeDescription") as? String { // 맛집 설명
                            storeDescription = desc
                        }
                    }
                }
        }
    }
        
    var body: some View {
        NavigationView {
            GeometryReader{ proxy in
                ScrollView{
                    VStack {
                        Text("\(storeType)")
                            .font(.headline)
                            .fontWeight(.regular)
                        
                        Text("\(storeName)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)

                        Text("\(storeAddress)")
                            .font(.title2)
                            .fontWeight(.regular)
                        
                        TabView{
                            ForEach(0..<3){ num in
                                    images[num]
                                    .resizable()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight:300, maxHeight: 300)
                        Text("\(storeDescription)")
                            .font(.title3)
                            .fontWeight(.regular)
                            .frame(width: 300, height: 300)
                    }
                } //VStack
            } // ScrollView
            .navigationBarHidden(true)
            .onAppear{
            }
        } // NavigationView
        .onAppear{
            FindData()
        }
    } // body
} // StoreInfoView

//struct StoreInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreInfoView(coordinate: CLLocationCoordinate2D(latitude: 30, longitude: 30))
//            .previewInterfaceOrientation(.portrait)
//    }
//}



        
