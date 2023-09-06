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
        // Private 생성자로 외부에서 인스턴스 생성 방지
        // 기존 사용자 데이터를 로드할 수 있도록 초기화 시에 데이터를 불러오는 로직을 추가할 수 있습니다.
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

    func updateUserInfo(userIndex: Int, newNickname: String, newIntroduce: String, newImage: UIImage?) {
        guard userIndex >= 0, userIndex < users.count else {
            return // 유효하지 않은 인덱스라면 업데이트하지 않음
        }

        // 해당 사용자의 정보를 업데이트
        users[userIndex].nickname = newNickname
        users[userIndex].introduce = newIntroduce

        // 이미지 업데이트
        if let newImage = newImage {
            users[userIndex].userImage = newImage
        }
        // 업데이트된 정보를 저장
        saveUsers()
    }

    // 사용자 데이터 초기화
    func clearUsers() {
        users.removeAll()
        userDefaults.removeObject(forKey: "users")
    }
}
