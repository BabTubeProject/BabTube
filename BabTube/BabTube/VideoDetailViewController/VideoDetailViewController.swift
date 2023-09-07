//
//  VideoDetailViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit
import WebKit

final class VideoDetailViewController: UIViewController {
    
    private let videoWebView: WKWebView = {
        let webViewConfiguration: WKWebViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .gray
        return webView
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
        tableView.isScrollEnabled = false
        return tableView
    }()
    private var tableViewheight: NSLayoutConstraint? = nil
    private let scrollView: UIScrollView = UIScrollView()
    
    private let videoDecriptionStackView: VideoDescriptionVerticalStackView = VideoDescriptionVerticalStackView()
    private let addCommentStackView: AddCommentStackView = AddCommentStackView()
    
    private let apiHandler: APIHandler = APIHandler()
    private let imageLoader: ImageLoader = ImageLoader()
    private let videoId: String
    private var snippet: Snippet?
    private var statistics: Statistics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureAutoLayout()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let tableViewheight else { return }
        tableViewheight.constant = commentTableView.contentSize.height + addCommentStackView.bounds.height
    }
    
    /// snippet이 있는 경우 사용
    init(snippet: Snippet, videoId: String) {
        self.snippet = snippet
        self.videoId = videoId
        super.init(nibName: nil, bundle: nil)
        
        loadVideo()
        DispatchQueue.global().async {
            self.getStatistics(videoId: videoId)
        }
    }
    
    /// videoId 만 있는 경우 사용
    init(videoId: String) {
        self.videoId = videoId
        super.init(nibName: nil, bundle: nil)
        
        loadVideo()
        DispatchQueue.global().async {
            self.getSnippetAndStatistics(videoId: videoId)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadVideo() {
        let stringUrl = "https://www.youtube.com/embed/\(videoId)?playsinline=1"
        guard let url = URL(string: stringUrl) else { return }
        let urlRequest = URLRequest(url: url)
        videoWebView.load(urlRequest)
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
        guard let snippet, let statistics else {
            print("snippet is nil")
            return
        }
        videoDecriptionStackView.updateArrangedSubviews(title: snippet.title, description: snippet.description, publishTime: snippet.publishedAt, statistics: statistics)
    }
    
}

// MARK: 기본 UISetting
extension VideoDetailViewController {
    
    private func configureTableView() {
        
        view.backgroundColor = UIColor.white
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
        
        addCommentStackView.layoutIfNeeded()
        let bottomInset = addCommentStackView.frame.height
        commentTableView.contentInset.bottom = bottomInset
    }
    private func addViews() {
        view.addSubview(videoWebView)
        view.addSubview(scrollView)
        scrollView.addSubview(videoDecriptionStackView)
        scrollView.addSubview(commentTableView)
        view.addSubview(addCommentStackView)
    }
    private func configureAutoLayout() {
        let framLayout = scrollView.frameLayoutGuide
        let contentLayout = scrollView.contentLayoutGuide
        let safeArea = view.safeAreaLayoutGuide
        let keyboardArea = view.keyboardLayoutGuide

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        videoDecriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        commentTableView.translatesAutoresizingMaskIntoConstraints = false
        addCommentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewheight = commentTableView.heightAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            videoWebView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: margin),
            videoWebView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: margin),
            videoWebView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -margin),
            videoWebView.heightAnchor.constraint(equalTo: videoWebView.widthAnchor, multiplier: 9.0/16.0),
            
            scrollView.topAnchor.constraint(equalTo: videoWebView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: margin),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -margin),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -margin),
            
            videoDecriptionStackView.topAnchor.constraint(equalTo: contentLayout.topAnchor, constant: 8),
            videoDecriptionStackView.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor),
            videoDecriptionStackView.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor),
            videoDecriptionStackView.widthAnchor.constraint(equalTo: framLayout.widthAnchor),
            
            commentTableView.topAnchor.constraint(equalTo: videoDecriptionStackView.bottomAnchor, constant: margin),
            commentTableView.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor),
            commentTableView.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor),
            commentTableView.bottomAnchor.constraint(equalTo: contentLayout.bottomAnchor),
            tableViewheight!,
            
            addCommentStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            addCommentStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            addCommentStackView.bottomAnchor.constraint(equalTo: keyboardArea.topAnchor),
        ])
    }
}

extension VideoDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.addSubview(commentLabel)
        return headerView
    }
}

extension VideoDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        return commentCell
    }

}
