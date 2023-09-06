//
//  SearchData.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import Foundation

struct SearchListData: Codable {
    let items: [Items]
}

struct Items: Codable {
    let id: VideoInfo
    let snippet: Snippet
}

struct VideoInfo: Codable {
    let kind: String
    let videoId: String
}

struct Snippet: Codable {
    let publishedAt: String
    let title: String
    let description: String
    let thumbnails: Thumbanils
    let channelTitle: String
}

struct Thumbanils: Codable {
    let `default`: ThumbanilsInfo
    let medium: ThumbanilsInfo
    let high: ThumbanilsInfo
}

struct ThumbanilsInfo: Codable {
    let url: String
    let width: Int
    let height: Int
}
