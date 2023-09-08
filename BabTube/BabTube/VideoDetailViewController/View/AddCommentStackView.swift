//
//  CommentStackView.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

final class AddCommentStackView: UIStackView {
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.tintColor = .systemGray6
        imageView.backgroundColor = .systemGray3
        return imageView
    }()
    private let commentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "댓글 추가"
        textView.font = .body
        textView.backgroundColor = .systemGray4
        textView.layer.cornerRadius = 5
        return textView
    }()
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .systemGray5
        return button
    }()
    
    private let margin: CGFloat = 12
    private let imageSize: CGFloat = 30

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureInit()
        addViews()
        configureView()
        configureAutoLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddCommentStackView {
    private func configureInit() {
        axis = .horizontal
        alignment = .center
        distribution = .fill
        spacing = 12
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        backgroundColor = .white
    }
    
    private func addViews() {
        addSubview(lineView)
        addArrangedSubview(profileImageView)
        addArrangedSubview(commentTextView)
        addArrangedSubview(sendButton)
    }
    
    private func configureView() {
        profileImageView.layer.cornerRadius = imageSize / 2
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
                            
            profileImageView.heightAnchor.constraint(equalToConstant: imageSize),
            profileImageView.widthAnchor.constraint(equalToConstant: imageSize),
        ])
    }
}
