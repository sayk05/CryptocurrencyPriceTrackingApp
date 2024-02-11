//
//  RequestsModel.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 19.12.23..
//

import Foundation

// MARK: - MyRequestsViewModel
final class MyRequestsViewModel: ObservableObject {
    
    @Published public var myRequests: [Request] = [
        
        //Examples
        Request(name: "Bitcoin", symbol: "BTC", priceHigherOrLower: true, myPrice: 200000),
        Request(name: "Litecoin", symbol: "LTC", priceHigherOrLower: false, myPrice: 400)
    ] {
        didSet {
            saveRequests()
        }
    }

    init() {
        self.myRequests = MyRequestsViewModel.loadRequests()
    }

     private func saveRequests() {
         do {
             let encoder = JSONEncoder()
             let data = try encoder.encode(myRequests)
             UserDefaults.standard.set(data, forKey: "items")
         } catch {
             // Handle error
             print("Error saving items: \(error)")
         }
     }

     private static func loadRequests() -> [Request] {
         guard let data = UserDefaults.standard.data(forKey: "items") else {
             return []
         }

         do {
             let decoder = JSONDecoder()
             return try decoder.decode([Request].self, from: data)
         } catch {
             print("Error loading items: \(CryptoError.decodingError)")
             return []
         }
     }
    
    func checkRequest(request: Request, correntPrice: String) -> Bool {
        if request.priceHigherOrLower && request.myPrice <= Double(correntPrice) ?? 0 || request.priceHigherOrLower == false && request.myPrice >= Double(correntPrice) ?? 0 {
            return true
        }
        return false
    }
    
    func addRequest(name: String, priceHigherOrLower: Bool, myPrice: Double, symbol: String, priceUsd: String, id: String) {
        
        self.myRequests.append(Request(name: name, symbol: symbol, priceHigherOrLower: priceHigherOrLower, myPrice: myPrice))
                          
    }
    
    
    func deleteRequest(at offsets: IndexSet) {
        myRequests.remove(atOffsets: offsets)
    }
}

// MARK: - Request
struct Request: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var symbol: String
    var priceHigherOrLower: Bool // true - higher; false - lower
    var myPrice: Double
    var completed: Bool?
}
