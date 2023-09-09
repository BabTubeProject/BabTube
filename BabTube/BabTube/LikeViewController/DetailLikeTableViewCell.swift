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
        addSubview(likeImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(contentLabel)

        // 오토레이아웃
        NSLayoutConstraint.activate([
            // thumbnailImageView
            likeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            likeImageView.widthAnchor.constraint(equalToConstant: 90), // 이미지 크기 조정
            likeImageView.heightAnchor.constraint(equalToConstant: 90),
            

            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: likeImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // subtitleLabel
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // contentLabel
            contentLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 16),
            contentLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    //cell에 표시될 api 데이터
    func likeUpdateUI(snippet: Snippet, items: [LikeVideo]) {
        self.likeVideoList = items
        titleLabel.text = snippet.title
        subtitleLabel.text = snippet.channelTitle
        contentLabel.text = snippet.description
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
