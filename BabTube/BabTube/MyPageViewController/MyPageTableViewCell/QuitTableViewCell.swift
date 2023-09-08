//
//  QuitTableViewCell.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/08.
//

import UIKit

class QuitTableViewCell: UITableViewCell {

    // Cell 식별자
    static let identifier = "QuitTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // 로그아웃 이미지
    private let quitImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "delete.right.fill")
        imageView.tintColor = UIColor.mainColor
        return imageView
    }()

    private let quitLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "탈퇴하기"
        label.font = .body
        label.textColor = UIColor.mainColor
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

extension QuitTableViewCell {
    
    private func addContentView() {
        contentView.addSubview(quitImageView)
        contentView.addSubview(quitLabel)
    }
    
    private func autoLayout() {
        let imageSize: CGFloat = 20
        NSLayoutConstraint.activate([
            quitImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            quitImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            quitImageView.widthAnchor.constraint(equalToConstant: imageSize),
            quitImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            quitLabel.leadingAnchor.constraint(equalTo: quitImageView.trailingAnchor, constant: 8),
            quitLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            quitLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
