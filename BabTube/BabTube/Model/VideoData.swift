//
//  SearchData.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import Foundation

// 검색 api 사용시 필요한 구조체
struct SearchDataList: Codable {
    let items: [SearchItems]
}

// 동영상 api 사용시 필요한 구조체
struct VideoDataList: Codable {
    let items: [VideosItems]
}

// 검색 api 사용시 사용되는 구조체
struct SearchItems: Codable {
    let id: VideoInfo
    let snippet: Snippet?
    let statistics: Statistics?
}

// 동영상 api 사용시 필요한 구조체
struct VideosItems: Codable {
    let id: String
    let snippet: Snippet?
    let statistics: Statistics?
}

struct VideoInfo: Codable {
    let kind: String
    let videoId: String
}

struct Statistics: Codable {
    let viewCount: String
    let likeCount: String
    let commentCount: String
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
