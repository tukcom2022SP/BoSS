//
//  ContentView.swift
//  BossSp
//
//  Created by 이정동 on 2022/08/05.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  var body: some View {
    switch viewModel.state {
      case .signedIn: MainView()
      case .signedOut: LoginView()
    }
  }
}

