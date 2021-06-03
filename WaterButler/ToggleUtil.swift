//
//  ToggleUtil.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import Foundation

class ToggleUtil{
public func createToggleMap(daysToggled: [String]) -> Dictionary<String, Bool>{

    var toggleDict: [String: Bool] = [:]
    let weekdays : [String] = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
    
    weekdays.forEach{weekday in
        toggleDict[weekday] = daysToggled.contains(weekday)
    }

    return toggleDict
}

}
