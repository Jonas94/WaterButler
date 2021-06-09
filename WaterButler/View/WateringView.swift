//
//  WateringView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-08.
//

import SwiftUI

struct WateringView: View {
    var watering : Watering1
    let apiCall = ApiCall()
    var body: some View {
    
        VStack(spacing: 10){
            VStack{
            
                Text("\(formatterDateOnly.string(from: DateUtil.getDateInSeconds(timeSince1970:watering.startDate)))").frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 40))
            }
            HStack{
                Text("\(formatterClockOnly.string(from: DateUtil.getDateInSeconds(timeSince1970:watering.startDate)))")

                Divider().frame(width: 2, height: 30, alignment: .center).background(Color.gray)
                Text("\(watering.duration) minuter")

            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private var formatterDateOnly: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "sv_SE")
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyy EEEEMMMMd")

    
    return dateFormatter
}()

private var formatterClockOnly: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "sv_SE")
    dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")

    
    return dateFormatter
}()


struct WateringView_Previews: PreviewProvider {
    static var previews: some View {
        WateringView(watering: Watering1(startDate: 1623217115083, stopDate: 20, duration: 6))
    }
}
