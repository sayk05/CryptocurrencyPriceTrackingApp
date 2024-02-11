//
//  Model.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 17.12.23..
//

import Foundation

// MARK: - CryptoModel
struct CryptoModel: Decodable {
    let data: [CyptoInfo]
    let timestamp: Int
}

// MARK: - CyptoInfo
struct CyptoInfo: Identifiable, Decodable {
    var id: String
    let symbol, name: String
    let priceUsd: String
}
