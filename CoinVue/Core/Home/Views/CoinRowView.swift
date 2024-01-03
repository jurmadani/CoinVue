//
//  CoinRowView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 30.12.2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing:0){
            
            leftColumn
    
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            rightColumn
         
        
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.acccent)
        }
    }
    
    private var centerColumn: some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.acccent)
    }
    
    private var rightColumn: some View{
        VStack(alignment: .trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(Color.theme.acccent)
            
            Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "0")")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}
