//
//  CoinViewModel.swift
//  CryptoPriceViewer
//
//  Created by Ulysses Castillo on 9/19/21.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
    
    private let cryptoService = CryptoService()
    
    @Published var coinViewModels = [CoinViewModel]()
    
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = cryptoService.fetchCoins().sink(receiveCompletion: { _ in
            
        }, receiveValue: { cryptoContainer in
            self.coinViewModels = cryptoContainer.data.coins.map { CoinViewModel($0) }
            print(self.coinViewModels)
        })
    }
}

struct CoinViewModel: Hashable {
    private let coin: Coin
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        guard let price = Double(coin.price), let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) else { return "" }
        
        return formattedPrice
    }
    
    var displayText: String {
        return name + " - " + formattedPrice
    }
    
    init(_ coin: Coin) {
        self.coin = coin
    }
}

