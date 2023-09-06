//
//  MainCollectionViewCell.swift
//  BabTube
//
//  Created by Hyunwoo Lee on 2023/09/05.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    //Cell 식별자
    static let id = "MainCVCell"
    
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
    }
}

