//
//  VideoDescriptionVerticalStackView.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/06.
//

import UIKit

class VideoDescriptionVerticalStackView: UIStackView {

    private let firstLineHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .title2
        return label
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .mainColor
        return button
    }()
    private let dateAndViewsContStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    private let videoDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020/02/01"
        label.font = .body
        return label
    }()
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "조회수 0회"
        label.font = .body
        return label
    }()
    private let videoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다설명입니다"
        label.font = .body
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureInit()
        addViews()
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VideoDescriptionVerticalStackView {
    private func configureInit() {
        axis = .vertical
        alignment = .leading
        distribution = .fill
        spacing = 8
    }
    
    private func addViews() {
        addArrangedSubview(firstLineHorizontalStackView)
        addArrangedSubview(dateAndViewsContStackView)
        addArrangedSubview(videoDescriptionLabel)

        dateAndViewsContStackView.addArrangedSubview(videoDateLabel)
        dateAndViewsContStackView.addArrangedSubview(viewsCountLabel)

        firstLineHorizontalStackView.addArrangedSubview(titleLabel)
        firstLineHorizontalStackView.addArrangedSubview(likeButton)
    }
    
    private func configureView() {
        likeButton.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
    }
    
    @objc private func likeButtonClick() {
        likeButton.isSelected.toggle()
    }
}
