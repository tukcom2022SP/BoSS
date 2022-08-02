//
//  ShowStoreInfoView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/29.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct StoreInfoView: View {
    
    @State private var storeAddress = "" // 맛집 주소
    @State private var storeName = "" // 맛집 이름
    @State private var storeType = "" // 맛집 종류
    @State private var storeDayOff = "" // 맛집 휴무일
    @State private var storeDescription = "" // 맛집 설명
    
    @State private var images : [Image] = [Image(""), Image(""), Image("")] // 이미지
    
    
    func FindData() { // 파이어베이스 데이터 조회 함수
        let db = Firestore.firestore() // 파이어베이스 인스턴스 초기화
        let ref = db.collection("stores").document("store1")
        ref.addSnapshotListener { (snapshot, error) in
            if error == nil {
                if let address = snapshot?.get("storeAddress") as? String {
                    storeAddress = address
                }
                if let name = snapshot?.get("storeName") as? String {
                    storeName = name
                }
                if let type = snapshot?.get("storeType") as? String {
                    storeType = type
                }
                if let dayOff = snapshot?.get("storeDayOff") as? String {
                    storeDayOff = dayOff
                }
                if let desc = snapshot?.get("storeDescription") as? String {
                    storeDescription = desc
                }
            }
        }
    }
    
    func FindImage(){ // 파이어스토리지 사진 다운로드 함수
        let storage = Storage.storage() // 파이어스토리지 인스턴스 초기화
        let storageRef = storage.reference()
    
        for num in 1...3 {
            let img = storageRef.child("store1/img\(num).jpg")
            img.downloadURL { (url, error) in
                if let url = url{
                    let data = NSData(contentsOf: url)
                    let image = UIImage(data: data! as Data)
                    images[num-1] = Image(uiImage: image!)
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
                            .foregroundColor(Color.gray)
                        
                        Text("\(storeName)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.black)

                        Text("\(storeAddress)")
                            .font(.title2)
                            .fontWeight(.regular)
                            .foregroundColor(Color.gray)
                        
                        TabView{
                            ForEach(0..<3){ num in
                                images[num]
                                    .resizable()
                                    .scaledToFill()
                                     .tag(num)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding()
                        .frame(width: proxy.size.width, height: proxy.size.height / 3)
                        
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
                    }
                } //VStack
            } // ScrollView
            .navigationBarHidden(true)
            .onAppear{
                
            }
        } // NavigationView
        .onAppear{
            FindData()
            FindImage()
        }
    } // body
} // StoreInfoView


struct StoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoreInfoView()
            .previewInterfaceOrientation(.portrait)
    }
}

        
