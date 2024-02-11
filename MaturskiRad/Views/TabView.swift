//
//  TabView.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 19.12.23..
//

import SwiftUI

struct TabbedView: View {
    @ObservedObject var myRequestsViewModel = MyRequestsViewModel()
    @ObservedObject var cryptoListViewModel = CryptoListViewModel()

    var body: some View {
        TabView {
            AllCoinsView(cryptoListViewModel: cryptoListViewModel)
                .tabItem {
                    Label("All Coins", systemImage: "house")
                }

            CreateRequestView(myRequestsViewModel: myRequestsViewModel)
                .tabItem {
                    Label("Create request", systemImage: "plus")
                }

            MyRequestsView(myRequestsViewModel: myRequestsViewModel, cryptoListViewModel: cryptoListViewModel)
            .tabItem {
                Label("My requests", systemImage: "star")
            }
        }
    }
}

#Preview {
    TabbedView()
}
