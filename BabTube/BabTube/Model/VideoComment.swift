//
//  CommentData.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/08.
//

import Foundation

struct Comment: Codable {
    let userId: String
    var profileImage: Data?
    var text: String
}
