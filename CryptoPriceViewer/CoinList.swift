//
//  ContentView.swift
//  CryptoPriceViewer
//
//  Created by Ulysses Castillo on 9/18/21.
//

import SwiftUI
import Combine

struct CoinList: View {
    
    @ObservedObject private var viewModel = CoinListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.coinViewModels, id: \.self) { coinViewModel in
                Text(coinViewModel.displayText)
            }.onAppear {
                self.viewModel.fetchCoins()
            }.navigationBarTitle("Coins")
        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinList()
    }
}

