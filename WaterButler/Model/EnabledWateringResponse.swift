//
//  EnabledWateringResponse.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-09.
//

import Foundation


struct EnabledWateringResponse : Decodable {
    var startDate : Int64
    var duration : Int64
    
    init(startDate: Int64, duration : Int64) {
        self.startDate = startDate
        self.duration = duration
    }

}


