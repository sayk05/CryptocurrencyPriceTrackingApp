//
//  CryptoError.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 10.2.24..
//

import Foundation

// MARK: - CryptoError
enum CryptoError: Error {
    case decodingError, networkError, invalidURL
}
