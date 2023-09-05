//
//  LogoutTableViewCell.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/04.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {
    
    // Cell 식별자
    static let identifier = "LogoutTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // 좋아요 이미지
    var logoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.forward.square")
        imageView.tintColor = UIColor.black
        return imageView
    }()

    var logoutLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "로그아웃"
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

extension LogoutTableViewCell {
    
    private func addContentView() {
        contentView.addSubview(logoutImageView)
        contentView.addSubview(logoutLabel)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            logoutImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logoutImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoutImageView.widthAnchor.constraint(equalToConstant: 20),
            logoutImageView.heightAnchor.constraint(equalToConstant: 20),
            
            logoutLabel.leadingAnchor.constraint(equalTo: logoutImageView.trailingAnchor, constant: 8),
            logoutLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            logoutLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
