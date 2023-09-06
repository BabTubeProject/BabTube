//
//  MainViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class MainViewController: UIViewController {
    
    private let sections: [String] = ["카테고리1","카테고리2","카테고리3","카테고리4","카테고리5","카테고리6"]
    
    var mainTableView: UITableView = {
        let mainTableView = UITableView()
        mainTableView.allowsSelection = false
        mainTableView.backgroundColor = .clear
        mainTableView.bounces = true
        mainTableView.contentInset = .zero
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        return mainTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTVAddSubView()
        mainTVAutoLayout()
        mainConfigureUI()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension MainViewController {
    
    //View에 TableView 추가
    private func mainTVAddSubView() {
        view.addSubview(mainTableView)
    }
    //TableView 오토레이아웃
    private func mainTVAutoLayout() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
    //네이게이션바에 로고 이미지 추가
    func mainConfigureUI() {
        
        let mainLogoImage = UIImageView()
        mainLogoImage.translatesAutoresizingMaskIntoConstraints = false
        mainLogoImage.image = UIImage(named: "BabTube_Logo")
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
        
        //        let svc = VideoDetailViewController()
        //        svc.modalPresentationStyle = .fullScreen
        //        self.present(svc, animated: true, completion: nil)
    }
    
    // section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    // header 폰트 속성 추가
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        header.textLabel?.textColor = UIColor.black
    }
    // section마다 표현될 title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    // section마다 표현될 row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as! MainTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.cellHeight
    }
    
}

