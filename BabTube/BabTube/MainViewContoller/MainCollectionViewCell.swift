//
//  MainCollectionViewCell.swift
//  BabTube
//
//  Created by Hyunwoo Lee on 2023/09/05.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    // Cell 식별자
    static let id = "MainCVCell"
    private let imageLoader = ImageLoader()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.systemGray5
        return imageView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        autoLayout()
    }
}

extension MainCVCell {
    private func addSubView() {
        contentView.addSubview(thumbnailImageView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height)
        ])
    }

    func updateCellImage(snippet: Snippet) {
        let stringURL: String = snippet.thumbnails.medium.url
        guard let url = URL(string: stringURL) else { return }
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
