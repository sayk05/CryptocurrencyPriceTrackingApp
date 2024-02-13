//
//  ViewModel.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 17.12.23..
//

import Foundation

// MARK: - CryptoListViewModel
final class CryptoListViewModel: ObservableObject {
    @Published var cryptocurrencyCoins: [CyptoInfo] = []
    
    init() {
        loadCrypto()
    }
}

extension CryptoListViewModel {
    @MainActor
    private func fetchCrypto() async throws {
        guard let url = URL(string: "https://api.coincap.io/v2/assets?ids=") else { throw CryptoError.invalidURL }
        
        do {
            guard let (data, _) = try? await URLSession.shared.data(from: url) else { throw CryptoError.networkError }
            guard let fetchedData = try? JSONDecoder().decode(CryptoModel.self, from: data) else { throw CryptoError.decodingError }
            DispatchQueue.main.async {
                //print(fetchedData)
                self.cryptocurrencyCoins = fetchedData.data
            }
        } catch {
            print(error)
        }
    }
    
    public func loadCrypto() {
        Task(priority: .high) {
            try await fetchCrypto()
        }
    }
}
