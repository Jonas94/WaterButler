//
//  ScheduledItemView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import SwiftUI

struct ScheduledItemView :View{
    var scheduledItem : ScheduledItem
    let apiCall = ApiCall()
    
    var body: some View {
        
        VStack(spacing: 10){
            HStack{
                Text(scheduledItem.time).frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 40))
                
                Toggle(isOn: Binding<Bool>(get: { scheduledItem.active },
                                           set: {newValue in
                                            scheduledItem.active = newValue
                                            apiCall.saveScheduledItem(scheduledItem: scheduledItem)
                                           }
                )){
                    //DO NOTHING
                }
                
            }
            HStack{
                Text("\(scheduledItem.duration, specifier: "%.0f") minuter" )
                Divider().frame(width: 2, height: nil, alignment: .center).background(Color.gray)
                Text(scheduledItem.days.joined(separator: ", "))
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


struct ScheduledItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduledItemView(scheduledItem: ScheduledItem(id: "id", time: "21:00", duration: 5, days: ["mon","tue"], active: true))
    }
}
