//
//  MainViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class MainViewController: UIViewController {
    private let sections: [String] = ["무한도전", "1박2일", "지구오락실"]

    var mainTableView: UITableView = {
        let mainTableView = UITableView()
        mainTableView.allowsSelection = false
        mainTableView.backgroundColor = .clear
        mainTableView.bounces = true
        mainTableView.contentInset = .zero
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.register(MainTVCell.self, forCellReuseIdentifier: MainTVCell.id)
        return mainTableView
    }()
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .title2
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let apiHandler: APIHandler = .init()
    private let imageLoader: ImageLoader = .init()
    private var searchItemList: [SearchItems]?
    private var everysearchItemList: [String: [SearchItems]] = [:]
    private var entertainmentTitle = ["무한도전", "1박2일", "지구오락실"]
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTVAddSubView()
        mainTVAutoLayout()
        mainConfigureUI()
        getSnippet()
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }

    private func getSnippet() {
        for title in entertainmentTitle {
            let query: [String: String] = ["part": "snippet", "maxResults": "5", "q": title]
            apiHandler.getSearchJson(query: query) { result in
                switch result {
                case .success(let searchDataList):
                    guard let items = searchDataList[title]?.items else { return }
                    self.everysearchItemList[title] = items
                    DispatchQueue.main.async {
                        self.mainTableView.reloadData()
                    }

                case .failure(let failure):
                    print(failure.message)
                }
            }
        }
    }
}

extension MainViewController {
    // View에 TableView 추가
    private func mainTVAddSubView() {
        view.addSubview(mainTableView)
    }

    // TableView 오토레이아웃
    private func mainTVAutoLayout() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }

    // 네이게이션바 로고 이미지
    func mainConfigureUI() {
        let mainLogoImage = UIImageView()
        mainLogoImage.translatesAutoresizingMaskIntoConstraints = false
        mainLogoImage.image = UIImage(named: "MainLogo")
        mainLogoImage.contentMode = .scaleAspectFit
        mainLogoImage.layer.masksToBounds = true
        mainLogoImage.widthAnchor.constraint(equalToConstant: 95).isActive = true
        mainLogoImage.heightAnchor.constraint(equalToConstant: 25.5).isActive = true

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainLogoImage)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // cell 터치시 회색 표시 없애기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
    }

    // cell의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTVCell.cellHeight
    }
    
    // section마다 표현될 title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 30
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        sectionTitle.text = sections[section]
//        headerView.addSubview(sectionTitle)
//        return headerView
//    }

    // UITableViewDataSource
    // section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    // section마다 표현될 row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTVCell.id, for: indexPath) as? MainTVCell else {
            return UITableViewCell()
        }
        cell.cellDelegate = self
        cell.selectionStyle = .none
        if everysearchItemList.count == 3 {
            if indexPath.section == 0 {
                guard let searchItemList = everysearchItemList[sections[indexPath.section]] else { return cell }
                cell.updateUI(items: searchItemList, section: indexPath.section)
                return cell
            }
            else if indexPath.section == 1 {
                guard let searchItemList = everysearchItemList[sections[indexPath.section]] else { return cell }
                cell.updateUI(items: searchItemList, section: indexPath.section)
                return cell
            }
            else if indexPath.section == 2 {
                guard let searchItemList = everysearchItemList[sections[indexPath.section]] else { return cell }
                cell.updateUI(items: searchItemList, section: indexPath.section)
                return cell
            }
        }
        return cell
    }
}

// cell 클릭시 VideoDetail 화면으로 이동
extension MainViewController: CollectionViewCellDelegate {
    func collectionView(section: Int, index: Int) {
        // 각 cell의 indexPath의 videoId를 전달
        guard let videoId = everysearchItemList[sections[section]]?[index].id.videoId else { return }
        let detailVC = VideoDetailViewController(videoId: videoId)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
