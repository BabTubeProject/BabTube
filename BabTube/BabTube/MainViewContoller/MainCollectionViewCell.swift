//
//  MainCollectionViewCell.swift
//  BabTube
//
//  Created by Hyunwoo Lee on 2023/09/05.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    static let id = "MainCVCell"
    
    let ThumbnailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        MainCVAddSubView()
        MainCVAutoLayout()
    }
}

extension MainCVCell {
    
    private func MainCVAddSubView() {
        self.addSubview(self.ThumbnailView)
    }
    
    private func MainCVAutoLayout() {
        NSLayoutConstraint.activate([
            self.ThumbnailView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.ThumbnailView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.ThumbnailView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.ThumbnailView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }
}
