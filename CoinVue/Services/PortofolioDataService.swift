//
//  PortofolioDataService.swift
//  CoinVue
//
//  Created by Daniel Jurma on 03.01.2024.
//

import Foundation
import CoreData

final class PortofolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortofolioContainer"
    private let entityName: String = "PortofolioEntity"
    
    @Published var savedEntities: [PortofolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
            self.getPortofolio()
        }
    }
    
    
    // MARK: PUBLIC
    
    func updatePortofolio(coin: CoinModel, amount: Double) {
        
        //check if coin is already in portofolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
      
        
    }
    
    // MARK: PRIVATE
    private func getPortofolio() {
        let request = NSFetchRequest<PortofolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portofolio entities. \(error)")
        }
    }
    
    private func update(entity: PortofolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortofolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortofolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortofolio()
    }
      
}
