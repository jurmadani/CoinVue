//
//  HomeViewModel.swift
//  CoinVue
//
//  Created by Daniel Jurma on 30.12.2023.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel : ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Market Cap", value: "$2.55Tr", percentageChange: 9.54),
        StatisticModel(title: "24h Volume", value: "$64.53Bn", percentageChange: -0.05),
        StatisticModel(title: "BTC Dominance", value: "42.57%"),
        StatisticModel(title: "Portofolio Value", value: "$32,934.12", percentageChange: 0.90)
    ]
    
    @Published var allCoins : [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
      addSubscribers()
    }
    
    func addSubscribers() {

        //updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
    }
}
