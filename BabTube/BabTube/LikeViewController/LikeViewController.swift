//
//  LikeViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

struct LikeData{
    let image: UIImage?
    let title: String
    let subtitle: String
    let contentLabel: String
}

class LikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //API 변수
    private let apiHandler: APIHandler = APIHandler()
    private let imageLoader: ImageLoader = ImageLoader()
    private var likeVideoList = UserDataManager.shared.getLikeVideos() {
        didSet {
            if likeVideoList.count == 0 {
                likeViewTable.isHidden = true
                nonLikeVideoLabel.isHidden = false
            }
            else {
                likeViewTable.isHidden = false
                nonLikeVideoLabel.isHidden = true
            }
        }
    }
    
    // 테이블 뷰 생성
    private let likeViewTable: UITableView = {
        let likeViewTable = UITableView()
        likeViewTable.translatesAutoresizingMaskIntoConstraints = false
        likeViewTable.estimatedRowHeight = 106
        likeViewTable.rowHeight = UITableView.automaticDimension
        return likeViewTable
    }()
    
    private let nonLikeVideoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "좋아요를 누른 동영상이 없습니다."
        label.font = .body
        label.textColor = UIColor.mainColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //네비게이션바 이미지 
        let likeTitleImageView = UIImageView()
        likeTitleImageView.translatesAutoresizingMaskIntoConstraints = false
        likeTitleImageView.image = UIImage(named: "BabTube_Logo")
        likeTitleImageView.contentMode = .scaleAspectFill
        likeTitleImageView.layer.masksToBounds = true
        likeTitleImageView.widthAnchor.constraint(equalToConstant: 95).isActive = true
        likeTitleImageView.heightAnchor.constraint(equalToConstant: 25.5).isActive = true

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.mainColor

        let likeTitleBarButtonItem = UIBarButtonItem(customView: likeTitleImageView)
        navigationItem.leftBarButtonItem = likeTitleBarButtonItem
       
        view.addSubview(likeViewTable)
        view.addSubview(nonLikeVideoLabel)
        
        // 테이블 뷰 오토레이아웃 설정
        NSLayoutConstraint.activate([
            likeViewTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            likeViewTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            likeViewTable.topAnchor.constraint(equalTo: view.topAnchor), // 네비게이션 바 아래부터 표시되도록 상단 여백 설정
            likeViewTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nonLikeVideoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nonLikeVideoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        likeViewTable.dataSource = self
        likeViewTable.delegate = self

        // 셀 등록
        likeViewTable.register(DetailLikeTableViewCell.self, forCellReuseIdentifier: "detailCellIdentifier")
        
        // 셀 사이 간격 줄 없앰
        likeViewTable.separatorStyle = .none
        likeViewTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        likeVideoList = UserDataManager.shared.getLikeVideos()
        DispatchQueue.main.async {
            self.likeViewTable.reloadData()
        }
    }

    // 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeVideoList.count
    }

    // 셀에 표시될 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailLikeTableViewCell
        
        guard let snippet = likeVideoList[indexPath.row].snippet else {
            return cell
        }
        cell.likeUpdateUI(snippet: snippet, items: likeVideoList)

        return cell
    }

    // 셀 눌렀을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        //VideoDetail 화면으로 이동 및 VideoID 넘겨주기
        if indexPath.row < likeVideoList.count {
            let videoId = likeVideoList[indexPath.row].videoId
            let videoDetail = VideoDetailViewController(videoId: videoId)
            navigationController?.pushViewController(videoDetail, animated: true)
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90
//    }
}
