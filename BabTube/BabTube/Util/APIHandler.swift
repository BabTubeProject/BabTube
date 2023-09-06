//
//  APIHandler.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import Foundation

final class APIHandler {
    private let baseUrl: String = "https://youtube.googleapis.com/youtube/v3/search?"
    private let sesstion: URLSession = URLSession.shared

    func getJson<T: Decodable>(type: T.Type, query: [String:String], completed: @escaping (Result<T, NetworkError>) -> Void) {
        let fullPath: String = baseUrl + query.map{ k, v in "\(k)=\(v)" }.joined(separator: "&") + 
        guard let url = URL(string: fullPath) else {
            completed(.failure(.url))
            return
        }
        
        task?.cancel()
        
        task = sesstion.dataTask(with: url) { data, response, error in
            if let error {
                let nsError = error as NSError
                if nsError.code == NSURLErrorCancelled {
                    completed(.failure(.cancel))
                } else if nsError.code == NSURLErrorNotConnectedToInternet || nsError.code == NSURLErrorTimedOut {
                    completed(.failure(.notConnectedToInternet))
                } else {
                    completed(.failure(.transport(error)))
                }
            } else {
                if let response = response as? HTTPURLResponse {
                    let statusCode = response.statusCode
                    
                    guard (200...299).contains(statusCode) else {
                        completed(.failure(.server(statusCode)))
                        return
                    }
                    guard let data else {
                        completed(.failure(.data))
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(type, from: data)
                        completed(.success(decodeData))
                        
                    } catch let DecodingError.dataCorrupted(context) {
                        completed(.failure(.decode(DecodingError.dataCorrupted(context))))
                    } catch let DecodingError.valueNotFound(value, context) {
                        completed(.failure(.decode(DecodingError.valueNotFound(value, context))))
                    } catch let DecodingError.keyNotFound(key, context) {
                        completed(.failure(.decode(DecodingError.keyNotFound(key, context))))
                    } catch let DecodingError.typeMismatch(type, context)  {
                        completed(.failure(.decode(DecodingError.typeMismatch(type, context))))
                    } catch let error {
                        completed(.failure(.other(error)))
                    }
                }
            }
        }
        
        task?.resume()
    }
    
}
