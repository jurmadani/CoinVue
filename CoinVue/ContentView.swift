//
//  ContentView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 30.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.red
                .ignoresSafeArea()
            
            VStack{
                Text("Accent Color")
                    .foregroundStyle(Color.theme.acccent)
                
                Text("Secondary text Color")
            }
        }
    }
}

#Preview {
    ContentView()
}
