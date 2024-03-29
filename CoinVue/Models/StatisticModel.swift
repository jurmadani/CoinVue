//
//  StatisticModel.swift
//  CoinVue
//
//  Created by Daniel Jurma on 02.01.2024.
//

import Foundation

struct StatisticModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    var value: String
    var percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
        
}
