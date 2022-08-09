//
//  LoadingView.swift
//  BossSp
//
//  Created by 홍길동 on 2022/08/01.
//

import SwiftUI

struct LoadingView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @StateObject var viewModel = AuthenticationViewModel()
    var body: some View {
        if isActive{
            ContentView()
                .environmentObject(viewModel)
        }else{
            ZStack {
                
                VStack{
                    Image("Icon")
                        .font(.system(size : 100))
                    Text("Loading...")
                        .font(Font.custom("Rockwell-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size=0.9
                        self.opacity = 1.0
                    }
                }
            }
           
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
