//
//  LoginView.swift
//  BossSp
//
//  Created by 이정동 on 2022/08/05.
//
import SwiftUI

struct LoginView: View {

    // 1
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        VStack {
            Spacer()
            // 2
//            Image("Icon")
//                .resizable()
//                .frame(width: 300, height: 300, alignment: .center)
//                .background(Color.white)

            Text("맛이 어때")
                .fontWeight(.black)
                .foregroundColor(Color.black)
                .font(.title)
                .multilineTextAlignment(.center)

            Text("지도에 맛집 위치를 표시해서 맛집 정보를 공유하세요.")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()


            // 3
            GoogleSignInButton()
                .frame(width: 130, height: 100, alignment: .center)
                .padding()
                .onTapGesture {
                  viewModel.signIn()
                }
            
            Spacer()
        }
    }
}

struct LoginView_Preview: PreviewProvider{
    static var previews: some View {
        LoginView()
    }
}

