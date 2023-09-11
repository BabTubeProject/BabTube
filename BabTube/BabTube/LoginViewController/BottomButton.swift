//
//  BottomButton.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/11.
//

import UIKit

class BottomButton: UIButton {

    private var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    var bottomViewBackgroundColor: UIColor {
        get {
            return backgroundColor ?? .systemGray5
        }
        set {
            bottomView.backgroundColor = newValue
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bottomView)
        cofigureAutoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cofigureAutoLayout() {
        guard let window = UIApplication.shared.windows.first else { return }
        let safeAreaHeigt = window.safeAreaInsets.bottom
        print(safeAreaHeigt)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: topAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: heightAnchor, constant: safeAreaHeigt),
        ])
    }
    
    func bottomViewBackgroun() {
        guard let window = UIApplication.shared.windows.first else { return }
        let safeAreaHeigt = window.safeAreaInsets.bottom
        print(safeAreaHeigt)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: topAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: heightAnchor, constant: safeAreaHeigt),
        ])
    }
}
