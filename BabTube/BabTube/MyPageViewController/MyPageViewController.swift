//
//  MyPageViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // TableView 만들기
    private let myPageTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        tableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: LogoutTableViewCell.identifier)
        tableView.register(QuitTableViewCell.self, forCellReuseIdentifier: QuitTableViewCell.identifier)
        
        // 경계선 없애기
        tableView.separatorStyle = .none
        
        // 스크롤 없애기
        tableView.isScrollEnabled = false
        
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    // API 활용을 위한 변수
    private let apiHandler: APIHandler = APIHandler()
    private let imageLoader: ImageLoader = ImageLoader()
    private var viewHistoryList = UserDataManager.shared.getViewHistory()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureMyPageUI()
        addSubView()
        autoLayout()
        
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewHistoryList = UserDataManager.shared.getViewHistory()
        print(viewHistoryList.map { $0.videoId })
        myPageTableView.reloadData()
    }
}

extension MyPageViewController {
    
    // UI 구성
    private func configureMyPageUI() {
        
        // view 배경색
        view.backgroundColor = UIColor.white
        
        // 네비게이션 바
        let navigationLogoImageView = UIImageView()
        navigationLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        navigationLogoImageView.image = UIImage(named: "MainLogo")
        navigationLogoImageView.contentMode = .scaleAspectFill
        navigationLogoImageView.layer.masksToBounds = true
        navigationLogoImageView.widthAnchor.constraint(equalToConstant: 95).isActive = true
        navigationLogoImageView.heightAnchor.constraint(equalToConstant: 25.5).isActive = true
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.mainColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationLogoImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(moveMyPageFixVC))
    }
    
    // view에 TableView 추가
    private func addSubView() {
        view.addSubview(myPageTableView)
    }
    
    // TableView에 autoLayout 추가
    private func autoLayout() {
        NSLayoutConstraint.activate([
            myPageTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myPageTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myPageTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myPageTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    // 마이페이지 수정 페이지 이동
    @objc private func moveMyPageFixVC() {
        let profileMakeVC = ProfileMakeViewController()
        profileMakeVC.changeToProfileEdit()
        navigationController?.pushViewController(profileMakeVC, animated: true)
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    // TableViewCell의 줄 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    // TableView의 각 줄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let profileTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            if let userImage = UserDataManager.shared.loginUser?.userImage {
                profileTableViewCell.profileImageView.image = UIImage(data: userImage)
            } else {
                profileTableViewCell.profileImageView.image = UIImage(systemName: "person.circle.fill")
            }
            if let nickName = UserDataManager.shared.loginUser?.nickname {
                profileTableViewCell.nameLabel.text = nickName
            } else {
                profileTableViewCell.nameLabel.text = "사용자"
            }
            profileTableViewCell.selectionStyle = .none
            return profileTableViewCell
        }

        else if indexPath.row == 1 {
            guard let recordTableViewCell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as? RecordTableViewCell else {
                return UITableViewCell()
            }
            recordTableViewCell.selectionStyle = .none
            recordTableViewCell.recordTableViewCellDelegate = self
            recordTableViewCell.updateUI(items: viewHistoryList)
            return recordTableViewCell
        }

        else if indexPath.row == 2 {
            guard let logoutTableViewCell = tableView.dequeueReusableCell(withIdentifier: LogoutTableViewCell.identifier, for: indexPath) as? LogoutTableViewCell else {
                return UITableViewCell()
            }
            logoutTableViewCell.selectionStyle = .none
            return logoutTableViewCell
        }
        
        else {
            guard let quitTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuitTableViewCell.identifier, for: indexPath) as? QuitTableViewCell else {
                return UITableViewCell()
            }
            quitTableViewCell.selectionStyle = .none
            return quitTableViewCell
        }
    }

    // Cell의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
            return 112
        }

        else if indexPath.row == 1 {
            return 164
        }
        
        else if indexPath.row == 2 {
            return 36
        }

        else {
            return 36
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            UserDataManager.shared.logout()
            dismiss(animated: true)
        }
        else if indexPath.row == 3 {
            guard let loginUser = UserDataManager.shared.loginUser else { return }
            UserDataManager.shared.removeUser(userID: loginUser.userID)
            dismiss(animated: true)
        }
    }
}

extension MyPageViewController: RecordTableViewCellDelegate {
    
    func didTapRecordCollectionViewCell(at indexPath: IndexPath) {
        if indexPath.row < viewHistoryList.count {
            let videoId = viewHistoryList[indexPath.row].videoId
            let videoDetailVC = VideoDetailViewController(videoId: videoId)
            navigationController?.pushViewController(videoDetailVC, animated: true)
        }
    }
}
