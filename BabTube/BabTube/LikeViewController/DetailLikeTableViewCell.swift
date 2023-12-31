//
//  DetailLikeTableViewCell.swift
//  BabTube
//
//  Created by 하호형 on 2023/09/05.
//

import UIKit

class DetailLikeTableViewCell: UITableViewCell {
    
    //API 변수
    private var likeVideoList: [LikeVideo]?
    private let imageLoader = ImageLoader()
    
    // 셀에 표시할 UI
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.title2
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.title3
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.title3
        return label
    }()

    // 셀의 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 셀에 추가
        contentView.addSubview(likeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(contentLabel)

        let space: CGFloat = 8
        // 오토레이아웃
        NSLayoutConstraint.activate([
            // thumbnailImageView
            likeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            likeImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: 157), // 이미지 크기 조정
            likeImageView.heightAnchor.constraint(equalToConstant: 88),

            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: space),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: space),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),

            // subtitleLabel
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: space),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 17),

            // contentLabel
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 2),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -space),
            contentLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    //cell에 표시될 api 데이터
    func likeUpdateUI(snippet: Snippet, items: [LikeVideo]) {
        self.likeVideoList = items
        DispatchQueue.main.async {
            self.titleLabel.text = snippet.title
            self.subtitleLabel.text = snippet.channelTitle
            self.contentLabel.text = snippet.description
        }
        let stringURL: String = snippet.thumbnails.medium.url
        guard let url = URL(string: stringURL) else { return }
        imageLoader.getImage(url: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.likeImageView.image = image
                }
            case .failure(let failure):
                print(failure.message)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
