//
//  SearchBarView.swift
//  CoinVue
//
//  Created by Daniel Jurma on 02.01.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.acccent
                )
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.acccent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.acccent)
                        .opacity(searchText.isEmpty ? 0 : 1.0)
                        .animation(.easeIn(duration: 0.25), value: searchText.isEmpty)
                        .onTapGesture {
                            searchText = ""
                        }
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.acccent.opacity(0.15), radius: 10, x:0, y:0)
        )
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
