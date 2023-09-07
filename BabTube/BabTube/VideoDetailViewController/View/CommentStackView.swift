//
//  CommentStackViewTest.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/08.
//

import UIKit

class CommentStackView: UIStackView {

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        return imageView
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다."
        label.font = .body
        label.numberOfLines = 0
        return label
    }()
    
    private let imageSize: CGFloat = 30
    
    init(frame: CGRect, image: UIImage?, comment: String) {
        super.init(frame: frame)
        profileImageView.image = image
        commentLabel.text = comment
        configureInit()
        addViews()
        configureView()
        configureAutoLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentStackView {
    private func configureInit() {
        axis = .horizontal
        alignment = .leading
        distribution = .fill
        spacing = 12
        backgroundColor = .white
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = 12
    }
    private func addViews() {
        addSubview(lineView)
        addArrangedSubview(profileImageView)
        addArrangedSubview(commentLabel)
    }
    private func configureView() {
        profileImageView.layer.cornerRadius = imageSize / 2
    }
    private func configureAutoLayout() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            profileImageView.widthAnchor.constraint(equalToConstant: imageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: imageSize),
        ])
    }
}
