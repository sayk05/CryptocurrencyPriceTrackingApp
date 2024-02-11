//
//  AllCoinsView.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 17.12.23..
//

import SwiftUI
import Kingfisher

struct AllCoinsView: View {
    @ObservedObject var cryptoListViewModel: CryptoListViewModel
    @State private var search = ""

    var body: some View {
            NavigationView {
                List(cryptoListViewModel.cryptocurrencyCoins.filter { search.isEmpty || $0.name.lowercased().contains(search.lowercased()) }) { coin in
                    
                    coinRow(name: coin.name, price: coin.priceUsd, image: "https://cryptologos.cc/logos/\(coin.name.lowercased().replacingOccurrences(of: " ", with: "-"))-\(coin.symbol.lowercased())-logo.png?v=029")
                }
                .searchable(text: $search)
                .frame(width: 400)
                .refreshable {
                    cryptoListViewModel.loadCrypto()
                }
            }
    }
}

@ViewBuilder
func coinRow(name: String, price: String, image: String) -> some View {
    HStack {
        KFImage(URL(string: image))
            .placeholder {
                Image(systemName: "questionmark.circle.fill")
                    .foregroundStyle(.gray)
                    .font(.system(size: 60))
            }
            .resizable()
            .frame(width: 60, height: 60)
        VStack(alignment: .leading) {
            Text(name)
                .bold()
            Text(price)
        }
    }
}

#Preview {
    AllCoinsView(cryptoListViewModel: CryptoListViewModel())
}
