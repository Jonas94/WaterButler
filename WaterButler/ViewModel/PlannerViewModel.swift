//
//  PlannerViewModel.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-09.
//

import Foundation

class PlannerViewModel : ObservableObject {
    @Published var showSuccessScreen : Bool = false

    init(showSuccessScreen : Bool) {
        self.showSuccessScreen = showSuccessScreen
    }
}
