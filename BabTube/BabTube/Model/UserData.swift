//
//  UserDaTa.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/05.
//

import UIKit

struct UserData: Codable {
    typealias VideoID = String
    typealias ThumbnailURL = String
    var name: String?
    var userID: String
    var password: String
    var nickname: String?
    var userImage: Data?
    var likeVideo: [VideoID:LikeVideo] = [:]
    var viewHistory: [ViewHistory] = []
}

struct LikeVideo: Codable {
    var likeTime: Date = Date()
    var videoId: String
    var snippet: Snippet?
    var videoThumbnail: String
}

struct ViewHistory: Codable {
    var videoId: String
    var videoThumbnail: String
}
