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

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}

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
        
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    Ellipse()
                        .fill(Color(0xffc857))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.1)
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        VStack(spacing : 0) {
                            HStack {
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                
                                Text("\(storeType)")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.black)
                            }

                            Text("\(storeName)").font(.system(size: 35, weight: .heavy, design: .rounded))
                                .foregroundColor(Color.black)

                            HStack{
                                Image(systemName: "map.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                
                                Text("\(storeAddress)")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.black)
                            }
                        }

                        TabView{
                            ForEach(0..<3){ num in
                                    images[num]
                                    .resizable()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(width: .infinity)
                        .aspectRatio(1.0 , contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding()
                        
                        Text("\(storeDescription)")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color(0x119da4))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .padding()
                    }
                }.onAppear{
                    FindData()
                }
            }
        }
    }
}
    
            
struct StoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoreInfoView(coordinate: CLLocationCoordinate2D(latitude: 37.341957167356455, longitude: 126.73214338899461))
            .previewInterfaceOrientation(.portrait)
    }
}



        
