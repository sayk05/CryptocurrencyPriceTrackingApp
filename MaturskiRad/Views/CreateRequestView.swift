//
//  CreateRequestView.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 20.12.23..
//

import SwiftUI

struct CreateRequestView: View {
    
    @ObservedObject var myRequestsViewModel: MyRequestsViewModel
    @ObservedObject var cryptoListViewModel = CryptoListViewModel()
    @State private var myPrice: String = ""
    @State private var price: Double = 0
    @State private var index = 0
    @State var priceHigherOrLower: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            TextField("Enter price", text: $myPrice)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numbersAndPunctuation)
            
            if !cryptoListViewModel.cryptocurrencyCoins.isEmpty {
                
                Slider(value: Binding(get: {
                    self.price
                }, set: { newValue in
                    self.price = newValue
                    myPrice = String(price)
                }), in: 0...(Double(cryptoListViewModel.cryptocurrencyCoins[index].priceUsd) ?? 0) * 4)
            }
            
            Toggle(isOn: $priceHigherOrLower) {
                Text("Will the price the be higher?")
            }
            
            Text(priceHigherOrLower ? "The price will be higher" : "The price will be lower")
                .padding()
            
                if !cryptoListViewModel.cryptocurrencyCoins.isEmpty {
                    VStack {
                        Picker("Select cryptocurrency", selection: $index) {
                            ForEach(0..<cryptoListViewModel.cryptocurrencyCoins.count) {
                                Text(cryptoListViewModel.cryptocurrencyCoins[$0].name)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        HStack {
                            Text("Selected:")
                            Text(cryptoListViewModel.cryptocurrencyCoins[index].name)
                                .bold()
                        }
                        .font(.system(size: 25))
                    }
                }
            Spacer()
            
            
            Button {
                myRequestsViewModel.addRequest(name: cryptoListViewModel.cryptocurrencyCoins[index].name, priceHigherOrLower: priceHigherOrLower, myPrice: (Double(myPrice) ?? 0), symbol: cryptoListViewModel.cryptocurrencyCoins[index].symbol, priceUsd: updatePrice(index: index), id: cryptoListViewModel.cryptocurrencyCoins[index].id)
                print("New request -> name: \(cryptoListViewModel.cryptocurrencyCoins[index].name), priceHigherOrLower: \(priceHigherOrLower), myPrice: \(Double(myPrice) ?? 0), symbol: \(cryptoListViewModel.cryptocurrencyCoins[index].symbol), priceUsd: \(updatePrice(index: index))")
            } label: {
                Text("Create Request")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
    func updatePrice(index: Int) -> String {
        cryptoListViewModel.cryptocurrencyCoins[index].priceUsd
    }
}


#Preview {
    CreateRequestView(myRequestsViewModel: MyRequestsViewModel(), priceHigherOrLower: true)
}
