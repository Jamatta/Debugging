//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {} // მხოლოდ ერთხელ უნდა შეგვეძლოს ამის გამოძახება
    
    func get<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                 completion(.failure(error))
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                    
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume() // არ ვიძაღებდით dataTask - ს
    }
}


