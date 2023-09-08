//
//  File.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/07.
//

import Foundation

extension String {
    var toDate: Date? {
        let dateForamtter = ISO8601DateFormatter()
        return dateForamtter.date(from: self)
    }
    var splitViewCount: String? {
        guard let number = Int(self) else { return nil }
        let unit = 10000
        let splitNumber = splitNumber(number, intoUnits: unit)
        if splitNumber.count == 1 {
            guard let number = splitNumber.last else { return nil }
            if number < 1000 {
                return "\(number)회"
            }
            return "\(number/1000)천 회"
        } else if splitNumber.count == 2 {
            guard let number = splitNumber.last else { return nil }
            return "\(number)만 회"
        } else if splitNumber.count == 3 {
            guard let number = splitNumber.last else { return nil }
            return "\(number)억 회"
        } else if splitNumber.count == 4 {
            guard let number = splitNumber.last else { return nil }
            return "\(number)조 회"
        }
        return nil
    }
    
    private func splitNumber(_ number: Int, intoUnits unit: Int) -> [Int] {
        var result = [Int]()
        var remaining = number

        while remaining > 0 {
            let currentUnit = remaining % unit
            result.append(currentUnit)
            remaining /= unit
        }

        return result
    }
}
