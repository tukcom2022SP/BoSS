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

            // 2
            Image(systemName: "person")
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .background(Color.gray)

            Text("Welcome to BoSS")
                .fontWeight(.black)
                .foregroundColor(Color(.systemIndigo))
                .font(.largeTitle)
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
        }
    }
}

struct LoginView_Preview: PreviewProvider{
    static var previews: some View {
        LoginView()
    }
}

