//
//  MainViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class MainViewController: UIViewController {
  
    private let sections: [String] = ["카테고리1","카테고리2","카테고리3","카테고리4","카테고리5","카테고리6"]
    
    var MainTableView: UITableView = {
        let MainTableView = UITableView()
        MainTableView.allowsSelection = false
        MainTableView.backgroundColor = .clear
        MainTableView.bounces = true
        MainTableView.contentInset = .zero
        MainTableView.translatesAutoresizingMaskIntoConstraints = false
        MainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        return MainTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainTVAddSubView()
        MainTVAutoLayout()
        configureUI()
        
        MainTableView.delegate = self
        MainTableView.dataSource = self
    }
}

extension MainViewController {
    
    //View에 TableView 추가
    private func MainTVAddSubView() {
        view.addSubview(MainTableView)
    }
    //TableView 오토레이아웃
    private func MainTVAutoLayout() {
        NSLayoutConstraint.activate([
            MainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            MainTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            MainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            MainTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Image"
        navigationItem.largeTitleDisplayMode = .never
    }

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    //셀 터치시 회색 표시 없애기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
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


