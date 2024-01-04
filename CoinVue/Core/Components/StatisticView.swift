//
//  StatisticView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 02.01.2024.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            
            //Title
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            
            //Value
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.acccent)
            
            
            HStack(spacing: 4){

                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                
                //Percentage change
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .bold()
            }
            .foregroundStyle(stat.percentageChange ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.stat3)
}
