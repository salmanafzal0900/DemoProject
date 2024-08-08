//
//  APIManager.swift
//  testAppSwift
//
//  Created by Salman Afzal on 07/08/2024.
//

import Foundation
import UIKit

enum APIError: Error {
    case networkError(Error)
    case serverError(statusCode: Int)
    case decodingError
    case unknownError
}

class APIManager {
    // Singleton pattern for a shared instance (optional)
    static let shared = APIManager()
    
    private init() {}
    
    // Generic API call function
    func fetchData<T: Decodable>(endpoint: APIEndpoints, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
      
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(.unknownError))
            return
        }
        
        print("*** API End Point Hit:",url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
           
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknownError))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
