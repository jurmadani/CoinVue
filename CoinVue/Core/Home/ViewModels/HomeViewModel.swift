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
    @Published var sortOption: SortOption = .holdings
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Market Cap", value: "$2.55Tr", percentageChange: 9.54),
        StatisticModel(title: "24h Volume", value: "$64.53Bn", percentageChange: -0.05),
        StatisticModel(title: "BTC Dominance", value: "42.57%"),
        StatisticModel(title: "Portofolio Value", value: "$0", percentageChange: 0.90)
    ]
    
    private let dataService = CoinDataService()
    private let portofolioDataService = PortofolioDataService()
    private var cancellables = Set<AnyCancellable>()
    private var portofolioValue: String = ""
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    private func updatePortofolioValue(newValue: String, newPercentageChange: Double){
        statistics[3].value = newValue
        statistics[3].percentageChange = newPercentageChange
    }
    
    func addSubscribers() {
        
        //updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //updates portofolio coins
        $allCoins
            .combineLatest(portofolioDataService.$savedEntities)
            .map(mapAllCoinsToPortofolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portofolioCoins = self.sortPortofolioCoinsIfNeeded(coins: returnedCoins)
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
    
    private func mapAllCoinsToPortofolioCoins(allCoins: [CoinModel], portofolioEntities: [PortofolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portofolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapPortofolioCoins(portofolioCoins: [CoinModel]) -> [StatisticModel] {
        let portofolioValue =
        portofolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue =
        portofolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portofolioValue - previousValue) / previousValue) * 100
        
        updatePortofolioValue(newValue: portofolioValue.asCurrencyWith2Decimals(), newPercentageChange: percentageChange)
        
        return self.statistics
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        // sort
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank })
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortofolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holding or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
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
