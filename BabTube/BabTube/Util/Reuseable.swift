//
//  Reuseable.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

protocol Reuseable {
    static var identifier: String { get }
}

extension Reuseable {
    static var identifier: String { "\(Self.self)" }
}
