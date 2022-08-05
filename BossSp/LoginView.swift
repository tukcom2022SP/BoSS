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
      Image("header_image")
        .resizable()
        .aspectRatio(contentMode: .fit)

      Text("Welcome to Ellifit!")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

      Text("Empower your elliptical workouts by tracking every move.")
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding()

      Spacer()

      // 3
      GoogleSignInButton()
        .padding()
        .onTapGesture {
          viewModel.signIn()
        }
    }
  }
}
