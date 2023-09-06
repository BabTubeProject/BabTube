//
//  UserDataManager.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/05.
//

import UIKit

class UserDataManager {
    static let shared = UserDataManager() // Singleton 인스턴스

    private let userDefaults = UserDefaults.standard

    private init() {
        loadUsers()
    }

    var users: [UserData] = []

    // 사용자 추가
    func addUser(userData: UserData) {
        users.append(userData)
        saveUsers()
    }

    // 사용자 목록 반환
    func getUsers() -> [UserData] {
        return users
    }

    // 사용자 데이터를 UserDefaults에 저장
    private func saveUsers() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(users) {
            userDefaults.set(encodedData, forKey: "users")
        }
    }

    // UserDefaults에서 사용자 데이터를 로드
    private func loadUsers() {
        if let savedData = userDefaults.data(forKey: "users") {
            let decoder = JSONDecoder()
            if let savedUsers = try? decoder.decode([UserData].self, from: savedData) {
                users = savedUsers
            }
        }
    }

    // 프로필 업데이트
    func updateUserInfo(userIndex: Int, newNickname: String, newIntroduce: String, newImage: UIImage?) {
        guard userIndex >= 0, userIndex < users.count else {
            return
        }

        // 해당 사용자의 정보를 업데이트
        users[userIndex].nickname = newNickname
        users[userIndex].introduce = newIntroduce

        // 이미지 업데이트
        if let newImage = newImage {
            users[userIndex].userImage = newImage.pngData()
        }
        // 업데이트된 정보를 저장
        saveUsers()
    }

    // 좋아요 표시한 동영상 저장하기
    func addLikeVideo(userIndex: Int, likeVideo: LikeVideo) {
        guard userIndex >= 0, userIndex < users.count else {
            return // 유효하지 않은 인덱스일 경우 처리하지 않음
        }

        users[userIndex].likeVideo.append(likeVideo)
        saveUsers()
    }

    // 좋아요 표시한 동영상 제거
    func removeLikeVideo(userIndex: Int, likeVideoIndex: Int) {
        guard userIndex >= 0, userIndex < users.count else {
            return // 유효하지 않은 사용자 인덱스
        }

        var user = users[userIndex]

        guard likeVideoIndex >= 0, likeVideoIndex < user.likeVideo.count else {
            return
        }

        user.likeVideo.remove(at: likeVideoIndex)
        saveUsers()
    }

    // 좋아하는 동영상 목록 반환
    func getLikeVideos(userIndex: Int) -> [LikeVideo] {
        guard userIndex >= 0, userIndex < users.count else {
            return []
        }

        return users[userIndex].likeVideo
    }

    // 사용자 데이터 초기화
    func clearUsers() {
        users.removeAll()
        userDefaults.removeObject(forKey: "users")
    }
}
