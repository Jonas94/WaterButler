//
//  DateUtil.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import Foundation
public class DateUtil{
   static func getDateInSeconds(timeSince1970: Double) -> Date{
        
        Date(timeIntervalSince1970: timeSince1970 / 1000)
    }
    
    
    static func getSecondsSince1970FromDate(date: Date) -> TimeInterval{
         
        date.timeIntervalSince1970
     }
    
    static func getDateFormatted(date: TimeInterval) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sv_SE")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm yyyy EEEEMMMMd ")
        return dateFormatter.string(from: DateUtil.getDateInSeconds(timeSince1970:date))
     }
    
    
    private var formatter: DateFormatter = {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatterPrint
    }()
    
    
    
}
