//
//  LoginViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        configButton()
        // Do any additional setup after loading the view.
    }
    
    private func configButton() {
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .systemGray5
        loginButton.frame.size = CGSize(width: 200, height: 100)
        loginButton.center = view.center
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
    }
    
    @objc private func loginButtonClick() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
