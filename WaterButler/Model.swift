//
//  Model.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-04-30.
//

import Foundation


struct TaskEntry: Codable  {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
