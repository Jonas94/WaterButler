//
//  HomeView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-12.
//

import SwiftUI
import GoogleSignIn

struct HomeView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  // 2
  private let user = GIDSignIn.sharedInstance().currentUser

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          // 3
          NetworkImage(url: user?.profile.imageURL(withDimension: 200))
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)

          VStack(alignment: .leading) {
            
            
            Text("Herr \(user?.profile.familyName ?? "") ")
                .font(.headline)

            
            Text(user?.profile.name ?? "")
              .font(.subheadline)
            

            Text(user?.profile.email ?? "")
              .font(.subheadline)
          }

          Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding()

        Spacer()

        // 4
        Button("Sign out") {
          viewModel.signOut()
        }
        .buttonStyle(AuthenticationButtonStyle())
      }
      .navigationTitle("Vattenmästare")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

/// A generic view that is helpful for showing images from the network.
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
