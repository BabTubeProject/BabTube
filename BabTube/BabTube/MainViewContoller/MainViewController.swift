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
        MainConfigureUI()
        
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
    //네이게이션바에 로고 이미지 추가
    func MainConfigureUI() {
        
        let MainLogoImage = UIImageView()
        MainLogoImage.translatesAutoresizingMaskIntoConstraints = false
        MainLogoImage.image = UIImage(named: "MainLogo")
        MainLogoImage.contentMode = .scaleAspectFit
        MainLogoImage.layer.masksToBounds = true
        MainLogoImage.widthAnchor.constraint(equalToConstant: 149).isActive = true
        MainLogoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: MainLogoImage)
        
    }

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // cell 터치시 회색 표시 없애기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainTableView.deselectRow(at: indexPath, animated: true)
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



