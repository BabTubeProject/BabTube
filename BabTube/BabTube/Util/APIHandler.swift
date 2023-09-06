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

    
    /**
        Json 형식으로 Youtube영상을 Serach하여 가져오는 기능을 하는 메서드
     
        - part: snippet으로 해야 영상 정보를 가져옴
        - maxResults: 한번에 가져올 데이터 갯수 최대 50 (기본값 5)
        - q: 검색할 내용
     ```
        let query = ["part": "snippet", "maxResults": "2", "q": "무한도전"]
        apiHandler.getJson(type: SearchListData.self, query: query) { result in
             switch result {
             case .success(let searchDataList):
                 print(searchDataList)
             case .failure(let failure):
                 print(failure.message)
             }
         }
     ```
     */
    func getJson<T: Decodable>(type: T.Type, query: [String:String], completed: @escaping (Result<T, NetworkError>) -> Void) {
        let fullPath: String = baseUrl + query.map{ k, v in "\(k)=\(v)" }.joined(separator: "&") + "&key=\(APIKEY)"
        print(fullPath)
        
        //URL에 한글이 들어가면 nil이 반환되어 encoding해주는 작업을 해줌
        guard let encoded = fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encoded) else {
            completed(.failure(.url))
            return
        }
        
        let task = sesstion.dataTask(with: url) { data, response, error in
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
                        print(context)
                        completed(.failure(.decode(DecodingError.dataCorrupted(context))))
                    } catch let DecodingError.valueNotFound(value, context) {
                        completed(.failure(.decode(DecodingError.valueNotFound(value, context))))
                    } catch let DecodingError.keyNotFound(key, context) {
                        print(context)
                        completed(.failure(.decode(DecodingError.keyNotFound(key, context))))
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print(context)
                        completed(.failure(.decode(DecodingError.typeMismatch(type, context))))
                    } catch let error {
                        completed(.failure(.other(error)))
                    }
                }
            }
        }
        
        task.resume()
    }
    
}
