//
//  LoginView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-12.
//

import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()

      // 2
    /*  Image("header_image")
        .resizable()
        .aspectRatio(contentMode: .fit)
*/
      Text("Välkommen till WaterButler!")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

      Text("Låt blommorna sköta sig själva")
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding()

      Spacer()

      // 3
      Button("Sign in with Google") {
        viewModel.signIn()
      }
      .buttonStyle(AuthenticationButtonStyle())
    }
  }
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}

// 4
struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemIndigo))
      .cornerRadius(12)
      .padding()
  }
}


