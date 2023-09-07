//
//  CommentVerticalStackView.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/08.
//

import UIKit

class CommentVerticalStackView: UIStackView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CommentVerticalStackView {
    private func configureInit() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 12
        backgroundColor = .white
    }
    
    func addComment(image: UIImage?, comment: String) {
        let commentStackView = CommentStackView(frame: .zero, image: image, comment: comment)
        addArrangedSubview(commentStackView)
    }
}
