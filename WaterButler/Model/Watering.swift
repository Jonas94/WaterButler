//
//  Watering.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import Foundation

struct Watering{
    let minutesToWater: Int
    let startDate: Date
    let stopDate: Date

    init(startDate : Double, stopDate : Double, minutesToWater : Int) {
        self.startDate = DateUtil.getDateInSeconds(timeSince1970: startDate)
        self.stopDate = DateUtil.getDateInSeconds(timeSince1970: stopDate)
        self.minutesToWater = minutesToWater
    }
    
   

}
