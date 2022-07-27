//
//  AddStoreView.swift
//  BossSp
//
//  Created by Juhee Park on 2022/07/26.
//

import SwiftUI

struct AddStoreView: View {
    
    let storeTypeArray = ["한식", "양식", "중식", "일식", "기타"]
    let storeDayOffArray = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "없음", "모름"]
    
    @State var storeAddress = "" // 맛집 주소
    @State var storename = "" // 맛집 이름
    @State var storeType = 0 // 맛집 종류
    @State var storeImage = "" // 맛집 이미지
    @State var storeDayOff = 0 // 맛집 휴무일
    @State var storeDescription = "" // 맛집 설명
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Form{
                    Section(header: Text("주소") // 주소 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Text("경기 시흥시 중심상가4길 18 이송빌딩 103호")
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("맛집 이름") // 맛집 이름 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            TextField("맛집 이름을 입력해주세요", text: $storename)
                                .keyboardType(.default)
                                .frame(width: 310.0, height: 50.0)
                    }
                    
                    Section(header: Text("음식 종류") // 음식 종류 입력 섹션
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)) {
                            Picker("음식 종류",selection: $storeType) {
                                ForEach( 0  ..< storeTypeArray.count ) {
                                    Text("\(self.storeTypeArray[$0])")
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
                                    Text("\(self.storeDayOffArray[$0])")
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
    
                } // Form
                
                Button ("등록") {
                    
                }
    
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
