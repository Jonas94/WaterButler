//
//  ScheduledItem.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-01.
//

import Foundation



class ScheduledItem: Identifiable, ObservableObject, Decodable{

    var id: String
    var time: String
    var duration: Double
    var days : [String]
    var active: Bool
    
    init(id: String, time: String, duration: Double, days : [String], active: Bool) {
        self.id = id
        self.time = time
        self.duration = duration
        self.days = days
        self.active = active
    }
    
    
}
