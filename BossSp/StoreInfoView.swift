//
//  ShowStoreInfoView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/29.
//

import SwiftUI
import FirebaseStorage
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
    
    @State private var image1 = Image("") // 이미지 1
    @State private var image2 = Image("") // 이미지 2
    @State private var image3 = Image("") // 이미지 3
    
    func FindImage(){ // 파이어스토리지 사진 다운로드 함수
        let storage = Storage.storage() // 파이어스토리지 인스턴스 초기화
        let storageRef = storage.reference()
        let img1 = storageRef.child("store1/img1.jpg")
        let img2 = storageRef.child("store1/img2.jpg")
        let img3 = storageRef.child("store1/img3.jpg")
        
        img1.downloadURL { (url, error) in
            if let url = url{
                let data = NSData(contentsOf: url)
                let image = UIImage(data: data! as Data)
                image1 = Image(uiImage: image!)
            }
        }
        
        img2.downloadURL { (url, error) in
            if let url = url{
                let data = NSData(contentsOf: url)
                let image = UIImage(data: data! as Data)
                image2 = Image(uiImage: image!)
            }
        }
        
        img3.downloadURL { (url, error) in
            if let url = url{
                let data = NSData(contentsOf: url)
                let image = UIImage(data: data! as Data)
                image3 = Image(uiImage: image!)
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
                            image1
                                .resizable()
                                .scaledToFill()
                                .tag(1)
                            
                            image2
                                .resizable()
                                .scaledToFill()
                                .tag(2)
                            
                            image3
                                .resizable()
                                .scaledToFill()
                                .tag(3)
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
                        
                        Button("조회") {
                            self.storeAddress = g_storeAddress // 맛집 주소
                            self.storeName = g_storeName // 맛집 이름
                            self.storeType = g_storeType // 맛집 종류
                            self.storeDayOff = g_storeDayOff // 맛집 휴무일
                            self.storeDescription = g_storeDescription // 맛집 설명
                        }.padding()
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

        
