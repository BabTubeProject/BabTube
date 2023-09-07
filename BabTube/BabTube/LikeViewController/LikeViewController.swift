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
    private var searchItemList: [SearchItems]?
    
    // 테이블 뷰 생성
    private let likeViewTable: UITableView = {
        let likeViewTable = UITableView()
        likeViewTable.translatesAutoresizingMaskIntoConstraints = false
        return likeViewTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeGetSnippet()

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
        // 테이블 뷰 오토레이아웃 설정
        NSLayoutConstraint.activate([
            likeViewTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            likeViewTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            likeViewTable.topAnchor.constraint(equalTo: view.topAnchor), // 네비게이션 바 아래부터 표시되도록 상단 여백 설정
            likeViewTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        likeViewTable.dataSource = self
        likeViewTable.delegate = self

        // 셀 등록
        likeViewTable.register(DetailLikeTableViewCell.self, forCellReuseIdentifier: "detailCellIdentifier")
        
        // 셀 사이 간격 줄 없앰
        likeViewTable.separatorStyle = .none
    }
    
    private func likeGetSnippet() {
        let query: [String: String] = ["part": "snippet", "maxResults": "5", "q": "무힌도전"]
        apiHandler.getSearchJson(query: query) { result in
            switch result {
            case .success(let searchDataList):
                self.searchItemList = searchDataList.items
                DispatchQueue.main.sync {
                    self.likeViewTable.reloadData()
                }
            case .failure(let failure):
                print(failure.message)
            }
        }
    }

    // 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItemList?.count ?? 0
    }

    // 셀에 표시될 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailLikeTableViewCell
        
        guard let searchItemList,
                let snippet = searchItemList[indexPath.row].snippet else {
            return cell
        }
        cell.likeUpdateUI(snippet: snippet, items: searchItemList)

        return cell
    }

    // 셀 눌렀을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //VideoDetail 화면으로 이동
            let videoDetail = VideoDetailViewController(videoId: "z8gl6HcWqCA" )
            navigationController?.pushViewController(videoDetail, animated: true)
    }
}
