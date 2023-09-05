//
//  LikeVideoTableViewCell.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/04.
//

import UIKit

class LikeVideoTableViewCell: UITableViewCell {
    
    // Cell 식별자
    static let identifier = "LikeVideoTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // 좋아요 이미지
    var likeVideoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()

    var likeVideoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "좋아요 표시한 동영상"
        label.font = .body
        label.textColor = UIColor.black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LikeVideoTableViewCell {
    
    private func addContentView() {
        contentView.addSubview(likeVideoImageView)
        contentView.addSubview(likeVideoLabel)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            likeVideoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            likeVideoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeVideoImageView.widthAnchor.constraint(equalToConstant: 20),
            likeVideoImageView.heightAnchor.constraint(equalToConstant: 20),
            
            likeVideoLabel.leadingAnchor.constraint(equalTo: likeVideoImageView.trailingAnchor, constant: 8),
            likeVideoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            likeVideoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
