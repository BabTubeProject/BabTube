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

    
    let cellData: [LikeData] = [
        LikeData(image: UIImage(named: ""), title: "제목1", subtitle: "소제목1", contentLabel: "내용1"),
        LikeData(image: UIImage(named: ""), title: "제목2", subtitle: "소제목2", contentLabel: "내용2")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 이미지 설정
        let titleImage = UIImage(named: "BabTube_Logo")

        // 네비게이션 바 타이틀 뷰 설정
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.contentMode = .scaleAspectFit

        // 이미지 크기 조정
        let imageSize = CGSize(width: 75.45, height: 20)
        titleImageView.frame = CGRect(origin: CGPoint.zero, size: imageSize)

        // 좌측 정렬을 위한 컨테이너 뷰
        let titleViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        titleViewContainer.addSubview(titleImageView)

        navigationItem.titleView = titleViewContainer

        // 테이블 뷰 생성
        let likeViewTable = UITableView()
        likeViewTable.translatesAutoresizingMaskIntoConstraints = false
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

    // 셀 내용
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailLikeTableViewCell
        
        cell.likeImageView.image = cellData[indexPath.row].image
        cell.titleLabel.text = cellData[indexPath.row].title
        cell.subtitleLabel.text = cellData[indexPath.row].subtitle
        cell.contentLabel.text = cellData[indexPath.row].contentLabel
        
        return cell
    }

    // 셀 눌렀을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let testViewController = UIViewController() // test 뷰 컨트롤러 생성
            testViewController.view.backgroundColor = .gray
            testViewController.title = "test"
            navigationController?.pushViewController(testViewController, animated: true) // test 뷰 컨트롤러로 이동
        }
        if indexPath.row == 1 {
            let testViewController2 = UIViewController() // test 뷰 컨트롤러 생성
            testViewController2.view.backgroundColor = .green
            testViewController2.title = "test2"
            navigationController?.pushViewController(testViewController2, animated: true) // test 뷰 컨트롤러로 이동
        }
    }
}
