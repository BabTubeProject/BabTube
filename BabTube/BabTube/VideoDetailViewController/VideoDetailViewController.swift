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
    private let commentStackView: CommentStackView = CommentStackView()
    
    private let apiHandler: APIHandler = APIHandler()
    private let imageLoader: ImageLoader = ImageLoader()
    private var snippet: Snippet?
    private var statistics: Statistics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureAutoLayout()
        configureTableView()
    }
    
    /// snippet이 있는 경우 사용
    init(snippet: Snippet, videoId: String) {
        self.snippet = snippet
        super.init(nibName: nil, bundle: nil)
        DispatchQueue.global().async {
            self.getStatistics(videoId: videoId)
        }
    }
    
    /// videoId 만 있는 경우 사용
    init(videoId: String) {
        super.init(nibName: nil, bundle: nil)
        DispatchQueue.global().async {
            self.getSnippetAndStatistics(videoId: videoId)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // snippet이 없는 경우 사용, snippet과 Statistics를 같이 가져오도록 하는 함수
    private func getSnippetAndStatistics(videoId: String) {
        let query: [String: String] = ["part": "snippet,statistics"]
        apiHandler.getVideoJson(query: query, videoId: videoId) { result in
            switch result {
            case .success(let videoDataList):
                self.snippet = videoDataList.snippet
                self.statistics = videoDataList.statistics
                self.updateViews()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // snippet이 있는 경우 사용, Statistics를 가져오도록 하는 함수
    private func getStatistics(videoId: String) {
        let query: [String: String] = ["part": "statistics"]
        apiHandler.getVideoJson(query: query, videoId: videoId) { result in
            switch result {
            case .success(let videoDataList):
                self.statistics = videoDataList.statistics
                self.updateViews()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func updateViews() {
        guard let snippet else {
            print("snippet is nil")
            return
        }
        let stringUrl = snippet.thumbnails.high.url
        guard let url = URL(string: stringUrl) else {
            print("url is nil")
            return
        }
        DispatchQueue.global().async {
            self.imageLoader.getImage(url: url) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.commentTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}

// MARK: 기본 UISetting
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
            guard let snippet, let statistics else { return descriptionCell }
            descriptionCell.updateView(title: snippet.title, description: snippet.description, publishTime: snippet.publishedAt, statistics: statistics)
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
