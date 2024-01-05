//
//  CoinVueApp.swift
//  CoinVue
//
//  Created by Daniel Jurma on 30.12.2023.
//

import SwiftUI

@main
struct CoinVueApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
          
            }
        }
    }
}
