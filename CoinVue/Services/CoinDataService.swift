//
//  CoinDataService.swift
//  CoinVue
//
//  Created by Daniel Jurma on 30.12.2023.
//

import Foundation
import Combine
import SwiftUI

final class CoinDataService{
    
    @Published var allCoins: [CoinModel] = []
    
    var decodeFromLocalJson: Bool = true
    
    var coinSubscription: AnyCancellable?
    
    init() {
        if !decodeFromLocalJson {
            getCoins()
        }
        else{
            getCoinsFromLocalJSON()
        }
    }
    
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
                self?.coinSubscription?.cancel()
            })
                
    }
    
    private func getCoinsFromLocalJSON() {
        if let fileURL = Bundle.main.url(forResource: "data", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileURL)
                    let decodedItems = try JSONDecoder().decode([CoinModel].self, from: data)
                    self.allCoins = decodedItems
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("JSON file not found.")
            }
    }
    
}
