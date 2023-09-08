//
//  Date.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/07.
//

import Foundation

extension Date {
    var diffrenceDate: String? {
        let currentDate = Date()
        let diffrenceDate = Calendar.current.dateComponents([.year,.month,.day,.hour], from: self, to: currentDate)
        if let year = diffrenceDate.year,
           !(year <= 0) {
            return "\(year)년전"
        } else if let mouth = diffrenceDate.month,
                  !(mouth <= 0) {
            return "\(mouth)개월 전"
        } else if let day = diffrenceDate.day,
                  !(day <= 0) {
            if day / 7 >= 1 {
                return "\(day / 7)주 전"
            }
            return "\(day)일 전"
        }
        return nil
    }
}
