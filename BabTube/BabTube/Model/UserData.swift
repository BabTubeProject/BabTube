//
//  UserDaTa.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/05.
//

import UIKit

struct UserData: Codable {
    var name: String?
    var userID: String?
    var password: String?
    var nickname: String?
    var introduce: String?
    var userImage: Data?
    var likeVideo: [LikeVideo] = []
}

struct LikeVideo: Codable {
    var videoId: String
    var videoThumbnail: String
}
