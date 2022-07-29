//
//  AddStoreView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/26.
//

import SwiftUI
import FirebaseFirestore

let storeTypeArray = ["한식", "양식", "중식", "일식", "기타"]
let storeDayOffArray = ["모름", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "없음"]

class store { // 가게 정보 클래스
    var storeAddress = "" // 맛집 주소
    var storeName = "" // 맛집 이름
    var storeType = "" // 맛집 종류
    var storeDayOff = "" // 맛집 휴무일
    var storeDescription = "" // 맛집 설명
    
    // 멤버 변수 초기화
    init(storeAddress: String,
         storeName : String,
         storeType : Int,
         storeDayOff : Int,
         storeDescription : String) {
        
        self.storeAddress = storeAddress
        self.storeName = storeName
        self.storeType = storeTypeArray[storeType]
        self.storeDayOff = storeDayOffArray[storeDayOff]
        self.storeDescription = storeDescription
    }
}

func InsertData(store : store) { // 파이어베이스 데이터 삽입
    let db = Firestore.firestore() // 파이어베이스 인스턴스 초기화
    db.collection("stores").document("store1").setData([
        "storeAddress" : "\(store.storeAddress)",
        "storeName" : "\(store.storeName)",
        "storeType" : "\(store.storeType)",
        "storeDayOff" : "\(store.storeDayOff)",
        "storeDescription" : "\(store.storeDescription)"])
}

struct AddStoreView: View {
    
    @State private var storeAddress = "경기 시흥시 중심상가4길 18 이송빌딩 103호" // 맛집 주소
    @State private var storeName = "" // 맛집 이름
    @State private var storeType = 0 // 맛집 종류
    @State private var storeImage = "" // 맛집 이미지
    @State private var storeDayOff = 0 // 맛집 휴무일
    @State private var storeDescription = "" // 맛집 설명
    
    @State private var showingAlert = false // 알림창 여부
    @State private var alert_msg = "" // 알림 메시지 내용
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
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
                            TextField("맛집 이름을 입력해주세요", text: $storeName)
                                .keyboardType(.default)
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("음식 종류") // 음식 종류 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Picker("음식 종류",selection: $storeType) {
                                ForEach( 0  ..< storeTypeArray.count ) {
                                    Text("\(storeTypeArray[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("사진") // 사진 등록 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            ScrollView(.horizontal) {
                                HStack(alignment: .center, spacing: 20) {
                                    VStack {
                                        Image("")
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                    
                                        Button ("사진 선택") {
                                            
                                        }
                                    }
                                    VStack {
                                        Image("")
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                    
                                        Button ("사진 선택") {
                                            
                                        }
                                    }
                                    VStack {
                                        Image("")
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                    
                                        Button ("사진 선택") {
                                            
                                        }
                                    }
                                }.padding() // HStack
                            } // ScrollView
                    } // Section
                    
                    Section(header: Text("휴무일") // 휴무일 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Picker("요일", selection: $storeDayOff) {
                                ForEach( 0  ..< storeDayOffArray.count ) {
                                    Text("\(storeDayOffArray[$0])")
                                }
                            }
                        }
                    
                    Section(header: Text("설명") // 설명 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            TextField("맛집 설명을 입력해주세요", text: $storeDescription)
                                .frame(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: 100.0)
                    }
                    
                    Button ("등록") {
                        if (storeName == "") { // 맛집 이름을 입력하지 않은 경우
                            showingAlert = true
                            alert_msg = "맛집 이름을 입력해주세요."
                        
                            
                        } else if (storeDescription == ""){ // 맛집 셜명을 입력하지 않은 경우
                            showingAlert = true
                            alert_msg = "맛집 설명을 입력해주세요."
                        }
                        
                        else { // 맛집 정보를 모두 올바르게 입력한 경우
                            let store_ob : store = store( // 맛집 정보 객체 생성
                                storeAddress : self.storeAddress,
                                storeName : self.storeName,
                                storeType : self.storeType,
                                storeDayOff : self.storeDayOff,
                                storeDescription : self.storeDescription
                            )
                            InsertData(store : store_ob) // 파이어스토어 데이터 삽입 함수
                        }
                    }.alert(isPresented: self.$showingAlert) { // 알림 메시지 설정
                        Alert(title: Text("알림"), message: Text("\(alert_msg)"), dismissButton: .default(Text("확인")))
                    }
                } // Form
            } // VStack
            .navigationBarTitle("맛집 등록")
        } // NavigationView
    } // body
} // AddStoreView


struct AddStoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreView()
            .previewInterfaceOrientation(.portrait)
    }
}
