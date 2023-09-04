//
//  MainViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var MainTableView: UITableView!
    var list: [String] = ["1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainTableView = UITableView()
        MainTableView.delegate = self
        MainTableView.dataSource = self
        view.addSubview(MainTableView)
        MainTableView.register(MainTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        //레이아웃
        MainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        MainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        MainTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        MainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        MainTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MainTableViewCell

        cell.lbl.text = list[indexPath.row]
        return cell
    }

    
//    NSLayoutConstraint.activate([
//    ])
//
}




