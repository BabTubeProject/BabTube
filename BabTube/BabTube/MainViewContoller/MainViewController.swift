//
//  MainViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class MainViewController: UIViewController {
    
    var MainTableView: UITableView = {
        let MainTableView = UITableView()
        MainTableView.translatesAutoresizingMaskIntoConstraints = false
        MainTableView.register(MainTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return MainTableView
    }()
    
    var list: [String] = ["1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainTVAddSubView()
        MainTVAutoLayout()
        
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
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MainTableViewCell
        cell.lbl.text = list[indexPath.row]
        return cell
    }
}


