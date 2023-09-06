//
//  LoginViewController.swift
//  BabTube
//
//  Created by 김도현 on 2023/09/04.
//

import UIKit

class LoginViewController: UIViewController {
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = .systemGray5
        btn.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
        view.addSubview(btn)
        return btn
    }()

    lazy var newMembership: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = .body
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(newMembershipClick), for: .touchUpInside)
        
        view.addSubview(btn)
        return btn
    }()

    lazy var babtubeIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "BabTube_Logo"))
        view.addSubview(icon)
        return icon
    }()

    lazy var emailText: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소"
        label.font = .body
        label.textColor = .black
        
        view.addSubview(label)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "babtube@gmail.com"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()
    
    lazy var passwordText: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .body
        label.textColor = .black
        view.addSubview(label)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "영문,숫자,특수문자"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUi()
        textFieldSetting()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeUi()
        textFieldSetting()
    }

    func textFieldSetting() {
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.clearButtonMode = .always
        emailTextField.spellCheckingType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.addLeftPadding()
        
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.clearButtonMode = .always
        passwordTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addLeftPadding()
    }

    @objc private func loginButtonClick() {        
    let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }

    @objc private func newMembershipClick() {
        print("pressed")
        let completeVC = MembershipViewController()
        navigationController?.pushViewController(completeVC, animated: false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            loginButton.backgroundColor = .systemGray5
        } else {
            loginButton.backgroundColor = .mainColor
        }
    }
}

extension LoginViewController {
    func makeUi() {
        
        view.backgroundColor = UIColor.white
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        babtubeIcon.translatesAutoresizingMaskIntoConstraints = false
        newMembership.translatesAutoresizingMaskIntoConstraints = false
        
        emailText.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            babtubeIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            babtubeIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            babtubeIcon.widthAnchor.constraint(equalToConstant: 200),
            babtubeIcon.heightAnchor.constraint(equalToConstant: 60),
            
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailText.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 5),
            emailText.heightAnchor.constraint(equalToConstant: 30),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordText.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 5),
            passwordText.heightAnchor.constraint(equalToConstant: 30),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            newMembership.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newMembership.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            newMembership.heightAnchor.constraint(equalToConstant: 30),

            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
}
