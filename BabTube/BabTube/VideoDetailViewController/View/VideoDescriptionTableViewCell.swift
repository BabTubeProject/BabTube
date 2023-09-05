//
//  VideoDescriptionTableViewCell.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import UIKit

class VideoDescriptionTableViewCell: UITableViewCell, Reuseable {
    
    private let videoDescriptionStackView = VideoDescriptionVerticalStackView()
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VideoDescriptionTableViewCell {
    private func addViews() {
        contentView.addSubview(videoDescriptionStackView)
        contentView.addSubview(lineView)
    }
    
    private func configureAutoLayout() {
        videoDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoDescriptionStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoDescriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoDescriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoDescriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
