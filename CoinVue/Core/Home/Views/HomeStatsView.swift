//
//  HomeStatsView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 02.01.2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortofolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                    StatisticView(stat: stat)
                        .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortofolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortofolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
