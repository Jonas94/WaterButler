//
//  CurrentWateringView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import SwiftUI

struct CurrentWateringView: View {
    var body: some View {
        VStack{
            
            VStack{
               /* Text("Start: \(watering.startDate)")
                Text("Stopp: \(watering.stopDate)")
                Text("antal minuter: \(watering.minutesToWater)")
*/
            }
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).padding()
        
            
            Button(action: {
                print("button pressed in current watering view")
            }, label: {
                Image(systemName: "stop.circle.fill").foregroundColor(.red).font(.system(size: 100))
            }).padding()
            
            Button(action: {
                print("button pressed in current watering view")
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath").foregroundColor(Color(red: 0 / 255, green: 0 / 255, blue: 128 / 255)
).font(.system(size: 100))

            }).padding(.top, 200)
        }
    }
}

struct CurrentWateringView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWateringView()
    }
}
