//
//  ProfileTableViewCell.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/04.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // Cell 식별자
    static let identifier = "ProfileTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 사용자 프로필 사진
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()

    // 사용자 이름
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "홍준영"
        label.font = .title2
        label.textColor = UIColor.black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileTableViewCell {
    
    private func addContentView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
    }
    
    private func autoLayout() {
        let imageSize: CGFloat = 80
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: imageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: margin),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
