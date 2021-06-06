//
//  ScheduledSuccessView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-05.
//

import SwiftUI

struct ScheduledSuccessView: View {
    var successText : String
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea(.all)

            VStack{
            Text("Success!").foregroundColor(.white)
                .font(.system(size: 40))
            
                Text(successText).foregroundColor(.white)
                    .font(.system(size: 20))
            
                
            
                Button("Cool!") {
                    print("Nice!")
                }.padding(.top, 100)
                
            }
            
        }.opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
    }
}

struct ScheduledSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduledSuccessView(successText: "Scheduled great at 18:00")
    }
}
