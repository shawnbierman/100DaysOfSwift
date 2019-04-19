//
//  Service.swift
//  Milestone5
//
//  Created by Shawn Bierman on 4/14/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import Foundation

class Service {
    
    fileprivate let baseAPIUrlString = "https://restcountries.eu/rest/v2/all?fields=name;capital;flag;area;population;region;currencies"
    
    static let shared = Service()
    
    func fetchCountries(completion: @escaping(Result<[Country], Error>) -> ()) {
        
        guard let request = buildRequest() else { return }
        fetchJSONDecodable(withRequest: request, completion: completion)
        
    }
    
    /// generic urlsession used in all network calls.
    fileprivate func fetchJSONDecodable<T: Decodable>(withRequest request: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(json))
                
            } catch let error {
                
                completion(.failure(error))
                
            }
        }
        
        task.resume()
    }
    
    fileprivate func buildRequest() -> URLRequest? {
        
        guard let url = URL(string: baseAPIUrlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
