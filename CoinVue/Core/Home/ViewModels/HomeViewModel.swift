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
    
 
    
    @Published var allCoins : [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    
    private let dataService = CoinDataService()
    private let portofolioDataService = PortofolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    private var portofolioValue: String = ""
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Market Cap", value: "$2.55Tr", percentageChange: 9.54),
        StatisticModel(title: "24h Volume", value: "$64.53Bn", percentageChange: -0.05),
        StatisticModel(title: "BTC Dominance", value: "42.57%"),
        StatisticModel(title: "Portofolio Value", value: "$0", percentageChange: 0.90)
    ]
    
    
    init() {
      addSubscribers()
    }
    
    private func updatePortofolioValue(newValue: String){
        statistics[3].value = newValue
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
        
        //updates portofolio coins
        $allCoins
            .combineLatest(portofolioDataService.$savedEntities)
            .map { (coinModels, portofolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portofolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoins) in
                self?.portofolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //update portofolio value
        $portofolioCoins
            .map(mapPortofolioCoins)
            .sink { [weak self] (returnedStatistics) in
                self?.statistics = returnedStatistics
            }
            .store(in: &cancellables)
    }
    
    func updatePortofolio(coin: CoinModel, amount: Double) {
        portofolioDataService.updatePortofolio(coin: coin, amount: amount)
    }
    
    private func mapPortofolioCoins(portofolioCoins: [CoinModel]) -> [StatisticModel] {
        let portofolioValue = 
        portofolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        updatePortofolioValue(newValue: portofolioValue.asCurrencyWith2Decimals())
        return self.statistics
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
