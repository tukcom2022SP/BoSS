//
//  SearchBar.swift
//  BossSp
//
//  Created by 홍길동 on 2022/07/27.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

       var body: some View {
           HStack {
               HStack {
                   Button(action: {print("das")}){
                       Image(systemName: "magnifyingglass")
                   }
                   
    
                   TextField("지역을 입력해주세요", text: $text)
                       .foregroundColor(.primary)
    
                   if !text.isEmpty {
                       Button(action: {
                           self.text = ""
                       }) {
                           Image(systemName: "xmark.circle.fill")
                       }
                   } else {
                       EmptyView()
                   }
               }
               .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
               .foregroundColor(.secondary)
               .background(Color(.secondarySystemBackground))
               .cornerRadius(10.0)
           }
           .padding(.horizontal)
       }
   }

