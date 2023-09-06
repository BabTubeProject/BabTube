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

//{
//    "kind": "youtube#searchListResponse",
//    "etag": "oJgq30m718oUEygZn8Phx7WSGLA",
//    "nextPageToken": "CAEQAA",
//    "regionCode": "KR",
//    "pageInfo": {
//        "totalResults": 1000000,
//        "resultsPerPage": 1
//    },
//    "items": [
//        {
//            "kind": "youtube#searchResult",
//            "etag": "1znR33M55y0iBCf3b8nUPgbXFGg",
//            "id": {
//                "kind": "youtube#video",
//                "videoId": "z8gl6HcWqCA"
//            },
//            "snippet": {
//                "publishedAt": "2023-09-05T08:30:08Z",
//                "channelId": "UC9idb-NIhZrI6wkPesc3MUg",
//                "title": "[#무한도전] 🙋‍♂형돈: 와 군대에서 먹던 라면맛이야❤ 🤦‍♂재석: 그럼 군대로 돌아가. | 무한도전⏱오분순삭 MBC080209방송",
//                "description": "오분순삭 #무한도전 *무한도전 다시 보기 ✓ WAVVE : https://www.wavve.com/player/vod?programid=M_T72108G&page=1 ...",
//                "thumbnails": {
//                    "default": {
//                        "url": "https://i.ytimg.com/vi/z8gl6HcWqCA/default.jpg",
//                        "width": 120,
//                        "height": 90
//                    },
//                    "medium": {
//                        "url": "https://i.ytimg.com/vi/z8gl6HcWqCA/mqdefault.jpg",
//                        "width": 320,
//                        "height": 180
//                    },
//                    "high": {
//                        "url": "https://i.ytimg.com/vi/z8gl6HcWqCA/hqdefault.jpg",
//                        "width": 480,
//                        "height": 360
//                    }
//                },
//                "channelTitle": "오분순삭",
//                "liveBroadcastContent": "none",
//                "publishTime": "2023-09-05T08:30:08Z"
//            }
//        }
//    ]
//}
