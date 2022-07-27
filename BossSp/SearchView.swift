//
//  SearchView.swift
//  BossSp
//
//  Created by 홍길동 on 2022/07/27.
//

import SwiftUI





struct SearchView: View {
    @State var array = [""]
    @State private var searchText = ""
    
    var body: some View {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }
                } //리스트의 스타일 수정
    
                  //화면 터치시 키보드 숨김
                
            }
           
                                  
                                        
                                    }
            
        }
    
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
 
 


