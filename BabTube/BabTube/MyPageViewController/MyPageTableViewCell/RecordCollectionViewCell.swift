//
//  RecordCollectionViewCell.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/05.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {
    
    // Cell 식별자
    static let identifier = "RecordCollectionViewCell"
    
    // 시청 기록 썸네일
    var thumbnailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordCollectionViewCell {
    
    private func addSubView() {
        contentView.addSubview(thumbnailImageView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height)
        ])
    }
}