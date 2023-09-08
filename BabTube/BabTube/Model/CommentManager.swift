//
//  CommentDataManager.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/08.
//

import Foundation

final class CommentManager {
    static let shared = CommentManager()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func saveCommentList(videoId: String, commentList: [Comment]) {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(commentList)
            userDefaults.set(encodedData, forKey: videoId)
        } catch let error {
            print(error)
        }
    }
    
    func loadCommetList(videoId: String) -> [Comment] {
        if let commentData = userDefaults.data(forKey: videoId) {
            let decoder = JSONDecoder()
            do {
                let comment = try decoder.decode([Comment].self, from: commentData)
                return comment
            } catch let error {
                print(error)
            }
        }
        return []
    }
}
