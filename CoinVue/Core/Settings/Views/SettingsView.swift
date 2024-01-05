//
//  SettingsView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 05.01.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/djurma")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://jurma.dev")!
    
    var body: some View {
        NavigationView {
            List {
                swiftfulThinkingSection
                coinGeckoSection
                developerSection
                
            }
            .accentColor(.blue)
            .font(.headline)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwitfulThinking course on Youtube. It uses MVVM Architecture, Combine, and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.acccent)
                
            }
            .padding(.vertical)
            
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko. Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.acccent)
                
            }
            .padding(.vertical)
            
            Link("Visit CoinGecko", destination: coingeckoURL)
            
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    
                    Image("memoji")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    
                    Image("dev-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
               
                
                Text("This app was developed by Daniel Jurma. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.acccent)
                
            }
            .padding(.vertical)
            
            Link("Visit Website", destination: personalURL)
            Link("Support my coffee addiction", destination: coffeeURL)
            
        } header: {
            Text("Developer")
        }
    }
    
    private var applicationSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    
                    Image("memoji")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    
                    Image("dev-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
               
                
                Text("This app was developed by Daniel Jurma. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.acccent)
                
            }
            .padding(.vertical)
            
            Link("Visit Website", destination: personalURL)
            
        } header: {
            Text("Developer")
        }
    }
}
