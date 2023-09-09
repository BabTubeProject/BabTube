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
    
    private let imageLoader = ImageLoader()
    
    // 시청 기록 썸네일
    private let thumbnailImageView: UIImageView = {
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
    
//    func updateCellImage(snippet: Snippet) {
//        let stringURL: String = snippet.thumbnails.medium.url
//        guard let url = URL(string: stringURL) else { return }
//        imageLoader.getImage(url: url) { result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self.thumbnailImageView.image = image
//                }
//            case .failure(let failure):
//                print(failure.message)
//            }
//        }
//    }
    func updateCellImage(viewHistory: ViewHistory) {
        let thumbnailStringURL = viewHistory.videoThumbnail
        guard let url = URL(string: thumbnailStringURL) else { return }
        imageLoader.getImage(url: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
}
