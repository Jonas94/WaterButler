//
//  Watering.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import Foundation

struct Watering : Decodable{
    let startDate: Date
    let stopDate: Date
    let duration: Int

    init(startDate : Double, stopDate : Double, duration : Int) {
        self.startDate = DateUtil.getDateInSeconds(timeSince1970: startDate)
        self.stopDate = DateUtil.getDateInSeconds(timeSince1970: stopDate)
        self.duration = duration
    }
    

    
   

}
