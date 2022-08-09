//
//  MypageView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/28.
//

import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseStorage

struct MypageView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var presentAlert = false
    @State var userName = ""// 닉네임
    @State var selfIntro = ""//자기 소개
    @State private var imagePro = Image("NoImage") //프로필 이미지
    @State private var uiImagePro = UIImage(systemName: "person")
    
    @State private var showingImagePicker = false // 이미지 피커 표시 여부
    @State private var inputImage: UIImage? // 갤러리에서 선택된 이미지
    @State private var editState: Bool = false
    @State private var showingAlert = false
    
    
    @ObservedObject var mapData = MapDataModel.shared.mapData
    
    func loadImage() { // 갤러리에서 선택된 이미지를 현재 이미지에 적용하는 함수
        guard let inputImage = inputImage else { return }

        imagePro = Image(uiImage: inputImage)
        uiImagePro = inputImage
        InsertImg()
    }
    
    func InsertData() { // 파이어베이스 데이터 업로드 함수
        let db = Firestore.firestore() // 파이어스토어 인스턴스 초기화
        let ref = db.collection("user").document("\(viewModel.getUserEmail())") // 참조
        
        ref.setData([ // 데이터 저장
                "userName" : userName, // 사용자 이름 저장
                "userIntroduce" : selfIntro]) // 사용자 소개 저장
        
        
    }
    
    func InsertImg() { // 파이어스토리지 이미지 업로드 함수
        let storage = Storage.storage() // 파이어스토리지 인스턴스 초기화
        let storageRef = storage.reference() // 참조
        
        let imageRef = storageRef.child("users/\(viewModel.getUserEmail())/selfImg.jpg")
        let data = uiImagePro!.jpegData(compressionQuality: 0.2)
        if let data = data {
            imageRef.putData(data)
        }
    }
    
    
    func FindData() { // 파이어베이스 데이터 조회 함수
        let db = Firestore.firestore() // 파이어베이스 인스턴스 초기화
        let ref = db.collection("user").document("\(viewModel.getUserEmail())") // 참조
        let storage = Storage.storage() // 파이어스토리지 인스턴스 초기화
        let storageRef = storage.reference() // 스토리지 참조
        let imgRef = storageRef.child("users/\(viewModel.getUserEmail())/selfImg.jpg") // 이미지 참조

        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                if let name = document.get("userName") as? String {
                    userName = name
                }
                if let intorduce = document.get("userIntroduce") as? String {
                    selfIntro = intorduce
                }
            }
        }
        
        imgRef.downloadURL { (url, error) in // url 다운로드
            if let url = url{
                let data = NSData(contentsOf: url) // url -> 데이터
                let image = UIImage(data: data! as Data) // 데이터 -> UI이미지
                imagePro = Image(uiImage: image!)
            }
        }
    }
            

    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    VStack{
                        imagePro
                        .resizable()
                        .frame(width: 150, height: 150)
                        .background(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black))
                        
                        Button (action:{
                            showingImagePicker = true
                    }){
                        Text("사진 추가")
                            .frame(minWidth: 0, maxWidth: 75)
                            .foregroundColor(Color.white)
                                        }.tint(.blue)
                                            .buttonStyle(.borderedProminent)
                                            .buttonBorderShape(.capsule)
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 20, trailing: 0))
                    }
                    .onChange(of: inputImage) { _ in loadImage() }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)}

                    if editState{
                        Button("변경사항 저장"){
                            editState = false
                            InsertData()
                        }
                        .frame(minWidth:300)
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle)
                        .foregroundColor(.black)
                    }else{
                        Button("프로필 편집"){
                            editState = true
                        }
                        .frame(minWidth:300)
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle)
                        .foregroundColor(.black)
                    }

                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .padding(20)
                    .background(Color("Color"))
                
                VStack(alignment: .leading){
                    Text("계정") // 맛집 이름 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    Text("\(viewModel.getUserEmail())")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 20,alignment: .leading)
                        .padding(10)
                        .background(Color("Color-1")).cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray))
                            
                
        
                    Text("닉네임")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    if editState{
                        TextField(self.userName, text: $userName)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .leading)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(.gray))
                    }else{
                        Text("\(userName)")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 20,alignment: .leading)
                            .padding(10)
                            .background(Color("Color-1")).cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray))
                            
                    }
                    
                    Text("자기 소개")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    if editState{
                        TextField(self.selfIntro, text: $selfIntro)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200,alignment: .topLeading)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(.gray))
                    }else{
                        Text("\(selfIntro)")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200,alignment: .topLeading)
                            .padding(10)
                            .background(Color("Color-1")).cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.gray))
                    }
                    
                    VStack {
                        Button {
                            self.showingAlert.toggle()
                        } label: {
                            Text("Sign out")
                              .foregroundColor(.white)
                              .padding()
                              .frame(maxWidth: .infinity)
                              .background(Color(.systemRed))
                              .cornerRadius(12)
                              .padding()
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text("Log out"), message: Text("로그아웃 하시겠습니까?"), primaryButton: .destructive(Text("로그아웃"), action: {
                                viewModel.signOut()
                                //some Action
                            }), secondaryButton: .cancel(Text("취소")))
                        }
                    }.padding(.horizontal, 60)
                }
                .padding()
            }
            .onAppear{
                FindData()
                print(viewModel.getUserEmail())
            }
        }
        
        
    }
    
}

