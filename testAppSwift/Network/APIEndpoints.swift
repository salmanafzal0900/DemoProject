//
//  APIEndpoints.swift
//  testAppSwift
//
//  Created by Salman Afzal on 07/08/2024.
//


import Foundation

enum APIEndpoints {
    
    static let baseURL = "https://itunes.apple.com/search"
    
    case songsByArtistName(name: String)
    
    var urlString: String {
        switch self {
        case .songsByArtistName(let name):
            return "\(APIEndpoints.baseURL)?term=\(name)&entity=song"
        }
    }
}
