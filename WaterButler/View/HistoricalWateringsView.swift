//
//  HistoricalWateringsView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-08.
//

import SwiftUI


struct HistoricalWateringsView: View {
    @ObservedObject var apiCall = ApiCall()
    
   // @State var isPaused : Bool = false
    var body: some View {
        VStack{
            if(true){
            //CatView(name: "cat", isPaused: true)
            }
            List{
                ForEach(apiCall.waterings, id: \.self){ item in
                            WateringView(watering: item)
                }.padding(.top)
                }
            
               .navigationTitle("Vattningar")
                .navigationBarTitleDisplayMode(.inline)
            
    }
        .onAppear{
        //    isPaused = false
            apiCall.loadHistoricalWaterings()
                }
    
    }
}
struct HistoricalWateringsView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalWateringsView()

    }
}
