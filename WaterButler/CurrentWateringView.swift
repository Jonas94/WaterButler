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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                print("button pressed in current watering view")
            }, label: {
                Text("STOP")
            })
            
            Button(action: {
                print("button pressed in current watering view")
            }, label: {
                Text("Reload")
            })

            
        }
    }
}

struct CurrentWateringView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWateringView()
    }
}
