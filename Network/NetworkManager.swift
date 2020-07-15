//
//  NetworkManager.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    @discardableResult
    func performRequest<D: Encodable, R: Decodable>(to endpoint: Endpoint, with jsonData: D, completion: @escaping (Result<R>) -> Void) -> URLSessionTask? {
        
        let urlComponents = NSURLComponents(url: endpointToUrl(endpoint)!, resolvingAgainstBaseURL: false)
        var httpBody: Data?
        
        do {
            let data = try JSONEncoder().encode(jsonData)
            if endpoint.method == .get {
                if let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    var queryItems = [URLQueryItem]()
                    for (key, value) in dict {
                        queryItems.append(URLQueryItem(name: key, value: "\(value)"))
                    }
                    queryItems.append(URLQueryItem(name: "api_key", value: "901c0dd771ce81601b4aedee20a2bb54"))
                    urlComponents?.queryItems = queryItems
                }
            } else {
                httpBody = data
            }
        } catch {
            completion(.failure(.jsonConversionFailure))
            return nil
        }
        
        guard let url = urlComponents?.url else { completion(.failure(.jsonConversionFailure)); return nil }
        
        var request = URLRequest(url: url.absoluteURL)
        request.httpBody = httpBody
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 10
        
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error, error._code == -999 {
                return completion(.failure(.requestCanceled))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.requestFailed))
            }
            
//            print(request.url, String(data: request.httpBody ?? Data(), encoding: .utf8), jsonData, String(data: data!, encoding: .utf8))

            if response.statusCode != 200 {
                return completion(.failure(.responseUnsuccessful))
            }
                        
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            do {
                let data = try JSONDecoder().decode(R.self, from: data)
                return completion(.success(data))
            } catch {
//                print(error.localizedDescription)
                return completion(.failure(.jsonParsingFailure))
            }
        }
        urlTask.resume()
        
        return urlTask
    }
    
    @discardableResult
    func loadImage(with imageUrl: URL?, completion: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        
        guard let url = imageUrl else { return nil }
        
        var request = URLRequest(url: url.absoluteURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 10
        
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error, error._code == -999 {
                return completion(.failure(.requestCanceled))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.requestFailed))
            }
            
            if response.statusCode != 200 {
                return completion(.failure(.responseUnsuccessful))
            }
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            return completion(.success(data))
        }
        urlTask.resume()
        
        return urlTask
    }
    
    fileprivate func endpointToUrl(_ endpoint: Endpoint) -> URL? {
        
        let urlString = "https://api.themoviedb.org/3/" + endpoint.pathEnding
        let url = URL(string: urlString)
        
        return url
    }
}
