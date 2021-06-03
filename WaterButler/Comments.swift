//
//  Comments.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-01.
//

import Foundation

struct Comments: Codable, Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let body: String
    
}
