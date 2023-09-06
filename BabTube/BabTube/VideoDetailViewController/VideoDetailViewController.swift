//
//  VideoDetailViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

final class VideoDetailViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "xmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.font = .title2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VideoDescriptionTableViewCell.self, forCellReuseIdentifier: VideoDescriptionTableViewCell.identifier)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private let commentStackView = CommentStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureAutoLayout()
        configureTableView()
    }

}

extension VideoDetailViewController {
    
    private func configureTableView() {
        
        view.backgroundColor = UIColor.white
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
        
        commentStackView.layoutIfNeeded()
        let bottomInset = commentStackView.frame.height
        commentTableView.contentInset.bottom = bottomInset
    }
    
    private func addViews() {
        view.addSubview(imageView)
        view.addSubview(commentTableView)
        view.addSubview(commentStackView)
    }

    private func configureAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        let keyboardArea = view.keyboardLayoutGuide

        commentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: margin),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: margin),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -margin),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7),
            
            commentTableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            commentTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: margin),
            commentTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -margin),
            commentTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -margin),

            commentStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            commentStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            commentStackView.bottomAnchor.constraint(equalTo: keyboardArea.topAnchor),
        ])
    }
}

extension VideoDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.addSubview(commentLabel)
        return section == 0 ? nil : headerView
    }
}

extension VideoDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            guard let descriptionCell = tableView.dequeueReusableCell(withIdentifier: VideoDescriptionTableViewCell.identifier, for: indexPath) as? VideoDescriptionTableViewCell else {
                return UITableViewCell()
            }
            cell = descriptionCell
        } else {
            guard let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else {
                return UITableViewCell()
            }
            cell = commentCell
        }
        return cell
    }
        
}
