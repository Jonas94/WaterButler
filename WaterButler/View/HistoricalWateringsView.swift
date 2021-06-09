//
//  HistoricalWateringsView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-08.
//

import SwiftUI

struct HistoricalWateringsView: View {
    let apiCall = ApiCall()
 //   @State var items = [Watering(startDate: 10, stopDate: 20, duration: 5), Watering(startDate: 10, stopDate: 20, duration: 5), Watering(startDate: 10, stopDate: 20, duration: 5)]
      @State var items = [Watering1(startDate: 10, stopDate: 20, duration: 5), Watering1(startDate: 10, stopDate: 20, duration: 5), Watering1(startDate: 10, stopDate: 20, duration: 5)]
   // @State var isPaused : Bool = false
    var body: some View {
        VStack{
            if(true){
            //CatView(name: "cat", isPaused: true)
            }
            List{
                ForEach(items, id: \.self){ item in
                            WateringView(watering: item)
                }.padding(.top)
                }
            //    .navigationTitle("Schemaläggare")
              //  .navigationBarTitleDisplayMode(.inline)
            
                }.onAppear{
                //    isPaused = false
                    apiCall.loadHistoricalWaterings()
                    apiCall.objectWillChange.send()
                    items = apiCall.waterings
        }
    }
}
struct HistoricalWateringsView_Previews: PreviewProvider {
    static var previews: some View {
//        HistoricalWateringsView(items: [Watering(startDate: 10, stopDate: 20, duration: 5)], isPaused: true)
        HistoricalWateringsView()

    }
}
