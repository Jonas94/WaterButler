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
    
}
