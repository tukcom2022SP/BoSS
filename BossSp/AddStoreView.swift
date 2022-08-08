//
//  AddStoreView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/26.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore // 파이어베이스 파이어스토어
import CoreLocation

let storeTypeArray = ["한식", "양식", "중식", "일식", "기타"] // 음식 종류 배열
let storeDayOffArray = ["모름", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "없음"] // 휴무일 배열

struct AddStoreView: View {
    @Binding var homePresenting: Bool
    @Binding var annotationTitle:String
    var coordinate: CLLocationCoordinate2D
    
    @State private var storeAddress = "" // 맛집 주소
    @State private var storeName = "" // 맛집 이름
    @State private var storeType = 0 // 맛집 종류
//    @State private var storeDayOff = 0 // 맛집 휴무일
    @State private var storeDescription = "" // 맛집 설명
    @State var placeholder: String = "맛집 설명을 입력해주세요." // 설명 TextEditor placeholder
    
    @State private var images : [Image] = [Image(""), Image(""), Image("")]
    @State private var uiImages : [UIImage] = [UIImage(named: "NoImage")!, UIImage(named: "NoImage")!, UIImage(named: "NoImage")!]
    @State private var nowImgNum = 0 // 현재 선택된 이미지 번호

    @State private var showingImagePicker = false // 이미지 피커 표시 여부
    @State private var inputImage: UIImage? // 갤러리에서 선택된 이미지
    
    @State private var showingAlert = false // 알림창 여부
    @State private var alert_msg = "" // 알림 메시지 내용
    
    @ObservedObject var storeModel = StoreModel.shared
    
   
    func InsertData() { // 파이어베이스 데이터 업로드 함수
        var storeCount = 0
        let db = Firestore.firestore() //
        let ref = db.collection("store").document("count")
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                if let cnt = document.get("storeCount") as? Int{
                    storeCount = cnt
                    storeCount += 1
                    ref.setData(["storeCount" : storeCount])
                    
                    db.collection("stores").document("store\(storeCount)").setData([ // 데이터 저장
                        "storeLatitude" : String(coordinate.latitude),
                        "storeLongitude" : String(coordinate.longitude),
                        "storeAddress" : storeAddress,
                        "storeName" : storeName,
                        "storeType" : "\(storeTypeArray[storeType])",
//                        "storeDayOff" : "\(storeDayOffArray[storeDayOff])",
                        "storeDescription" : storeDescription])
                    
                    
                    // 파이어스토리지 사진 업로드
                    let storage = Storage.storage() // 파이어스토리지 인스턴스 초기화
                    let storageRef = storage.reference()
                    
                    for num in 0...2 {
                        let imageRef = storageRef.child("store\(storeCount)/img\(num+1).jpg")
                        let data = uiImages[num].jpegData(compressionQuality: 0.2)
                        if let data = data {
                            imageRef.putData(data)
                        }
                    }
                }
            }
        }
    }
    
    func loadImage(num : Int) { // 갤러리에서 선택된 이미지를 현재 이미지에 적용하는 함수
        guard let inputImage = inputImage else { return }
        if (num == 1){
            images[0] = Image(uiImage: inputImage)
            uiImages[0] = inputImage
        } else if (num == 2){
            images[1] = Image(uiImage: inputImage)
            uiImages[1] = inputImage
        } else if (num == 3){
            images[2] = Image(uiImage: inputImage)
            uiImages[2] = inputImage
        }
    }
    
    var body: some View {
        
        VStack{
            Form{
                Section(header: Text("주소") // 주소 입력 섹션
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)) {
                        TextField("맛집 주소를 입력해주세요", text: $storeAddress)
                            .keyboardType(.default)
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
                                    images[0]
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                        .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                                    
                                    Text("사진 선택")
                                        .foregroundColor(Color.blue)
                                        .onTapGesture {
                                            showingImagePicker = true
                                            self.nowImgNum = 1
                                        }
                                }
                                
                                VStack {
                                    images[1]
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                        .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                                    
                                    Text("사진 선택")
                                        .foregroundColor(Color.blue)
                                        .onTapGesture {
                                            showingImagePicker = true
                                            self.nowImgNum = 2
                                        }
                                }
                                
                                VStack {
                                    images[2]
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                        .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                                    
                                    Text("사진 선택")
                                        .foregroundColor(Color.blue)
                                        .onTapGesture {
                                            showingImagePicker = true
                                            self.nowImgNum =  3
                                        }
                                }
                                
                            }.padding() // HStack
                                .onChange(of: inputImage) { _ in loadImage(num: self.nowImgNum) }
                                .sheet(isPresented: $showingImagePicker) {
                                    ImagePicker(image: $inputImage)}
                                
                                
                        } // ScrollView
                } // Section
                
//                Section(header: Text("휴무일") // 휴무일 입력 섹션
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color.black)) {
//                        Picker("요일", selection: $storeDayOff) {
//                            ForEach( 0  ..< storeDayOffArray.count ) {
//                                Text("\(storeDayOffArray[$0])")
//                            }
//                        }
//                    }
                
                Section(header: Text("설명") // 설명 입력 섹션
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)) {
                        
                        ZStack {
                            if self.storeDescription.isEmpty { // 맛집 설명 입력 TextEditor가 비었을 때 표시
                                TextEditor(text: $placeholder)
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .disabled(true)
                            }
                            
                            TextEditor(text: $storeDescription) // 맛집 설명 입력 TextEditor
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .center)
                                .multilineTextAlignment(.leading)
                        }
                }
                Button {
                    if (storeAddress == "") { // 맛집 주소를 입력하지 않은 경우
                        showingAlert = true
                        alert_msg = "맛집 주소를 입력해주세요."
                    } else if (storeName == "") { // 맛집 이름을 입력하지 않은 경우
                        showingAlert = true
                        alert_msg = "맛집 이름을 입력해주세요."
                    } else if (storeDescription == ""){ // 맛집 셜명을 입력하지 않은 경우
                        showingAlert = true
                        alert_msg = "맛집 설명을 입력해주세요."
                    }
                    else { // 맛집 정보를 모두 올바르게 입력한 경우
                        InsertData() // 파이어스토어 데이터 업로드
                       
                        homePresenting = false // Home 화면으로 Back
                        annotationTitle = storeName
                        
                        storeModel.stores.append((
                            strName: storeName,
                            strAddress: storeAddress,
                            strDescript: storeDescription,
                            strType: storeTypeArray[storeType],
                            strLatitude: String(coordinate.latitude),
                            strLongitude: String(coordinate.longitude)))
                    }

                    print(coordinate)

                    //homePresenting = false
                } label: { Text("등록")}
                    .alert(isPresented: self.$showingAlert) { // 알림 메시지 설정
                    Alert(title: Text("알림"), message: Text("\(alert_msg)"), dismissButton: .default(Text("확인"))) }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            } // Form
            .navigationBarTitle("맛집 등록")
        } // VStack
    } // body
} // AddStoreView


//struct AddStoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddStoreView(coordinate: CLLocationCoordinate2D(latitude: 38, longitude: 127))
//            .previewInterfaceOrientation(.portrait)
//    }
//}
