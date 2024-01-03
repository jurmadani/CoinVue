//
//  HomeView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 30.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPortofolioView: Bool = false
    @EnvironmentObject private var vm : HomeViewModel
    
    var body: some View {
        ZStack{
            //background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortofolioView, content: {
                    PortofolioView()
                        .environmentObject(vm)
                })
            
            //content layer
            VStack{
                homeHeader

                HomeStatsView(showPortofolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                
                
                if showPortfolio {
                    portofolioCoinsList
                    .transition(.move(edge: .trailing))
                }
         
                
               
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    NavigationView{
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}


extension HomeView {
    private var homeHeader : some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio {
                        showPortofolioView.toggle()
                    }
                }
            
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text(showPortfolio ? "Portofolio" : "Coin Vue")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.acccent)
                .animation(.none, value: showPortfolio)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portofolioCoinsList: some View {
        List {
            ForEach(vm.portofolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack{
            Text("Coin")
            
            Spacer()
            
            if showPortfolio{
                Text("Holdings")
            }
        

            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
