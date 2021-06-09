//
//  ScheduledSuccessView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-05.
//

import SwiftUI

struct ScheduledSuccessView: View {
    var enabledWateringResponse : EnabledWateringResponse
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var apiCall = ApiCall()

    var body: some View {
        
        let successText = "Vattning i \(enabledWateringResponse.duration) minuter är nu planerad till \(DateUtil.getDateFormatted(date: TimeInterval(enabledWateringResponse.startDate)))"
        
        ZStack{
            Color.green.ignoresSafeArea(.all)

            VStack{
            Text("Alright polarn!").foregroundColor(.white)
                .font(.system(size: 40))
            
                Text(successText).foregroundColor(.white)
                    .font(.system(size: 20))
            
                VStack{

                Button(action: {
                    apiCall.showSuccessScreen = false
                    apiCall.objectWillChange.send() //TODO: remove this?
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                  Image(systemName: "checkmark.circle")
                  Text("Schysst kompis!")
           
                }
                .padding()
                .font(.title)
                //.background(Color.green)

                .foregroundColor(.white)
                .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple, lineWidth: 5)
            )
                    
                }.padding(.top, 50)
            }.padding()
            
        }.opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
    
}

struct ScheduledSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduledSuccessView(enabledWateringResponse: EnabledWateringResponse(startDate: 10000, duration: 5))
    }
}
