//
//  WaterInput.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-04.
//

import Foundation

struct WaterInput: Codable, Identifiable {
    let id = UUID()
    let minutesToWater: Int
    let startDate: Date
    
}
