//
//  ViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSetting()
        viewControllerSetting()
    }
    
    private func tabBarSetting() {
        self.tabBar.backgroundColor = .white
        self.modalPresentationStyle = .fullScreen
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.tintColor = UIColor.mainColor
    }

    private func viewControllerSetting() {
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: LikeViewController())
        let vc3 = UINavigationController(rootViewController: MyPageViewController())

        vc1.title = "홈"
        vc2.tabBarItem.title = "좋아요"
        vc3.title = "마이페이지"

        self.setViewControllers([vc1, vc2, vc3], animated: false)

        guard let items = self.tabBar.items else { return }

        let images = ["house", "heart", "person"]

        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
        }
    }
}

