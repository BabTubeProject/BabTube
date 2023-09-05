//
//  MainCollectionViewCell.swift
//  BabTube
//
//  Created by Hyunwoo Lee on 2023/09/05.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    static let id = "MainCVCell"
    public var lbl: UILabel!
    
    
    
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
        setup()
       
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
    private func setup() {
        lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        contentView.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    }
}
