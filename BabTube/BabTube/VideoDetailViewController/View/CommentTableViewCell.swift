//
//  CommentTableViewCell.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import UIKit

final class CommentTableViewCell: UITableViewCell, Reuseable {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다."
        label.font = .body
        label.numberOfLines = 0
        return label
    }()
    
    private let topBottomMargin: CGFloat = 8
    private let imageSize: CGFloat = 30

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        configureAutoLayout()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CommentTableViewCell {
    private func addViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(commentLabel)
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomMargin),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -topBottomMargin),
            profileImageView.heightAnchor.constraint(equalToConstant: imageSize),
            profileImageView.widthAnchor.constraint(equalToConstant: imageSize),
            
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomMargin),
            commentLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topBottomMargin),
        ])
    }
    
    private func configureViews() {
        profileImageView.layer.cornerRadius = imageSize / 2
    }
}
