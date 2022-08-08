//
//  MypageView.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/28.
//

import SwiftUI
import MapKit

struct MypageView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var presentAlert = false
    @State var userName = ""// 닉네임
    @State var selfIntro = ""//자기 소개
    @State private var imagePro = Image("")//프로필 이미지
    @State var num = 0
    @State private var showingImagePicker = false // 이미지 피커 표시 여부
    @State private var inputImage: UIImage? // 갤러리에서 선택된 이미지
    @State private var editState: Bool = false
    @State private var showingAlert = false
    
    
    @ObservedObject var mapData = MapDataModel.shared.mapData
    
    func loadImage(num : Int) { // 갤러리에서 선택된 이미지를 현재 이미지에 적용하는 함수
        guard let inputImage = inputImage else { return }
        if (num == 1){
            imagePro = Image(uiImage: inputImage)
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
                            self.num = 1
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
                    .onChange(of: inputImage) { _ in loadImage(num: self.num) }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)}

                    if editState{
                        Button("변경사항 저장"){
                            editState = false
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
                            
                
        
                    Text("닉네임") // 맛집 이름 입력 섹션
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
                    
                    
                    
                    Text("자기 소개")// 맛집 이름 입력 섹션
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
                print(viewModel.getUserEmail())
            }
        }
        
        
    }
    
}

