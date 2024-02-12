//
//  MyRequestsView.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 19.12.23..
//

import SwiftUI
import Kingfisher

struct MyRequestsView: View {
    @ObservedObject var myRequestsViewModel: MyRequestsViewModel
    @ObservedObject var cryptoListViewModel: CryptoListViewModel

    var body: some View {
        VStack {
            
            List {
                ForEach(myRequestsViewModel.myRequests) { request in
                    RequestView(correntPrice: cryptoListViewModel.cryptocurrencyCoins.filter { $0.name == request.name }[0].priceUsd, request: Request(name: request.name, symbol: request.symbol, priceHigherOrLower: request.priceHigherOrLower, myPrice: request.myPrice), isCompleted: myRequestsViewModel.checkRequest(request: request, correntPrice: cryptoListViewModel.cryptocurrencyCoins.filter { $0.name == request.name }[0].priceUsd))
                }
                .onDelete(perform: myRequestsViewModel.deleteRequest)
            }
        }
        
    }
}
struct RequestView: View {
    var correntPrice: String
    var request: Request
    @State var isCompleted: Bool
    
    var body: some View {
        HStack {
            
            KFImage(URL(string: "https://cryptologos.cc/logos/\(request.name.lowercased())-\(request.symbol.lowercased())-logo.png?v=029"))
                .placeholder {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundStyle(.gray)
                        .font(.system(size: 60))
                }
                .resizable()
                .frame(width: 60, height: 60)
            VStack {
                Text(request.symbol)
                    .bold()
                if !isCompleted {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "x.square.fill")
                        .foregroundStyle(.red)
                }
            }
            VStack(alignment: .leading) {
                Text("Corrent price: \(correntPrice)")
                Text("Your price: \(request.myPrice)")
            }
            Spacer()
        }
        .frame(height: 70)
    }
}

#Preview {
//    MyRequestsView(myRequestsViewModel: MyRequestsViewModel(), cryptoListViewModel: CryptoListViewModel())
    RequestView(correntPrice: "Bitcoin", request: Request(name: "Bitcoin", symbol: "BTC", priceHigherOrLower: true, myPrice: 932.32), isCompleted: true)
}

