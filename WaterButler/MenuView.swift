//
//  MenuView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-30.
//

import SwiftUI


struct MenuView: View {
    var body: some View {
            VStack(alignment: .leading) {
                
                HStack{
                    NavigationLink(
                        destination: PlannerView(),
                        label: {
                            MenuButtonView(text: "Manuell vattning", imageName: "gift")
                        })
                }
                .padding(.top, 200)
                
                HStack {
                    NavigationLink(
                        destination: SchedulerView(),
                        label: {
                           MenuButtonView(text: "Schemalagd vattning", imageName: "gift")
                        })
                }
                .padding(.top, 30)
                
                HStack{
                    NavigationLink(
                        destination: CatView(name: "cat", isPaused: false),
                        label: {
                            MenuButtonView(text: "Katten!", imageName: "gift")
                        })
                }
                .padding(.top, 30)
                HStack {
                    NavigationLink(
                        destination: CurrentWateringView(),
                        label: {
                            MenuButtonView(text: "Aktuell vattning", imageName: "gift")
                        })
               
                }
                .padding(.top, 30)
                Spacer()
            }.padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


struct MenuButtonView: View {
    var text : String
    var imageName : String
    
    var body: some View {
            Text(text)
                .font(.headline)
                .foregroundColor(.gray)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
