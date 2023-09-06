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
    
    let thumbnailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainCVAddSubView()
        mainCVAutoLayout()
        setup()
        
    }
}

extension MainCVCell {
    
    //cell안의 UIView를 View에 추가
    private func mainCVAddSubView() {
        self.addSubview(self.thumbnailView)
    }
    
    //CollectionViewCell 레이아웃
    private func mainCVAutoLayout() {
        NSLayoutConstraint.activate([
            self.thumbnailView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.thumbnailView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.thumbnailView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.thumbnailView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }
    
    //보여주기 데이터를 위한 라벨 속성
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
