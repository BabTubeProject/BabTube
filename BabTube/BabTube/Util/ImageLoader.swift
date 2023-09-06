//
//  ImageLoader.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import Foundation
import UIKit

final class ImageLoader {
    func getImage(url: URL, completed: @escaping (Result<UIImage, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                let nsError = error as NSError
                
                // 인터넷이 연결되지 않았거나, 요청 시간을 초과한 경우 에러 처리
                if nsError.code == NSURLErrorNotConnectedToInternet || nsError.code == NSURLErrorTimedOut {
                    completed(.failure(.notConnectedToInternet))
                } else {
                    completed(.failure(.transport(error)))
                }
            } else {
                if let response = response as? HTTPURLResponse {
                    let statusCode = response.statusCode
                    
                    // HTTPSatusCode가 200번대가 아닌경우 서버 에러
                    guard (200...299).contains(statusCode) else {
                        completed(.failure(.server(statusCode)))
                        return
                    }
                    guard let data else {
                        completed(.failure(.data))
                        return
                    }
                    guard let image = UIImage(data: data) else {
                        completed(.failure(.data))
                        return
                    }
                    completed(.success(image))
                }
            }
        }.resume()
    }
}
