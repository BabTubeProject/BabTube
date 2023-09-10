//
//  UserDataManager.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/05.
//

import UIKit

class UserDataManager {
    typealias VideoID = String
    typealias ThumnalURL = String
    static let shared = UserDataManager() // Singleton 인스턴스

    private let userDefaults = UserDefaults.standard

    private init() {
        loadUsers()
    }

    var users: [UserData] = []
    
    var loginUser: UserData?
    
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
        do {
            let encodedData = try encoder.encode(users)
            userDefaults.set(encodedData, forKey: "users")
        } catch {
            print("사용자 추가 중 에러 발생: \(error)")
        }
    }

    // UserDefaults에서 사용자 데이터를 로드
    private func loadUsers() {
        if let savedData = userDefaults.data(forKey: "users") {
            let decoder = JSONDecoder()
            do {
                let savedUsers = try decoder.decode([UserData].self, from: savedData)
                users = savedUsers
            } catch {
                print("사용자데이터를 UserDefaults에서 로드 \(error)")
            }
        }
    }

    // 프로필 업데이트
    func updateUserInfo(userIndex: Int, newNickname: String, newImage: UIImage?) throws {
        guard userIndex >= 0, userIndex < users.count else {
            return
        }
        // 해당 사용자의 정보를 업데이트
        users[userIndex].nickname = newNickname
        // 이미지 업데이트
        if let newImage = newImage {
            users[userIndex].userImage = newImage.pngData()
        }

        // 업데이트된 정보를 저장
        saveUsers()
    }

    // 좋아요 표시한 동영상 저장하기
    func addLikeVideo(userID: String, likeVideo: LikeVideo) {
        guard let userIndex = users.firstIndex(where: { $0.userID == userID }) else { return }
        loginUser?.likeVideo[likeVideo.videoId] = likeVideo
        users[userIndex].likeVideo[likeVideo.videoId] = likeVideo
        saveUsers()
    }

    // 좋아요 표시한 동영상 제거
    func removeLikeVideo(userID: String, likeVideoID: String) {
        guard let userIndex = users.firstIndex(where: { $0.userID == userID }) else { return }
        
        loginUser?.likeVideo[likeVideoID] = nil
        users[userIndex].likeVideo[likeVideoID] = nil
        saveUsers()
    }

    // 좋아하는 동영상 목록 반환
    func getLikeVideos() -> [LikeVideo] {
        guard let loginUser else { return [] }
        return loginUser.likeVideo.values.sorted(by: { $0.likeTime > $1.likeTime })
    }
    
    func addViewHistory(userID: String,viewHistory: ViewHistory){
        guard let userIndex = users.firstIndex(where: { $0.userID == userID }) else { return }
        loginUser?.viewHistory[viewHistory.videoId] = viewHistory
        let loginViewHistory = getViewHistory()
        if loginViewHistory.count >= 10 {
            if let videoId = loginViewHistory.last?.videoId {
                loginUser?.viewHistory[videoId] = nil
            }
        }
        users[userIndex].viewHistory[viewHistory.videoId] = viewHistory
        saveUsers()
    }
    
    func removeViewHistory(userID: String, viewHistoryID: String){
        guard let userIndex = users.firstIndex(where: { $0.userID == userID }) else { return }
        
        loginUser?.viewHistory[viewHistoryID] = nil
        users[userIndex].viewHistory[viewHistoryID] = nil
        saveUsers()
    }
    
    func getViewHistory() -> [ViewHistory] {
        guard let loginUser else { return [] }
        return loginUser.viewHistory.values.sorted(by: { $0.viewTime > $1.viewTime })
    }
    func logout() {
        loginUser = nil
    }
    // 사용자 데이터 초기화
    func removeUser(userID: String) {
        users.removeAll()
        userDefaults.removeObject(forKey: "users")
    }
}
