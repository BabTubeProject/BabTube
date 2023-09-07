//
//  MembershipViewController.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/04.
//

import UIKit

class MembershipViewController: UIViewController {
    lazy var signUp: UIButton = {
        let btn = UIButton()
        btn.setTitle("가입하기", for: .normal)
        btn.backgroundColor = .mainColor
        btn.addTarget(self, action: #selector(membershipPressed), for: .touchUpInside)
        
        view.addSubview(btn)
        return btn
    }()
    
    lazy var titles: UILabel = {
        let lb = UILabel()
        lb.text = "회원가입"
        lb.font = .title3
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    lazy var name: UILabel = {
        let lb = UILabel()
        lb.text = "이름"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "홍길동"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()
    
    lazy var emailAdress: UILabel = {
        let lb = UILabel()
        lb.text = "이메일주소"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    lazy var emailAdressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "babtube@gmail.com"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()
    
    lazy var password: UILabel = {
        let lb = UILabel()
        lb.text = "비밀번호"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
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
    
    lazy var passwordCheck: UILabel = {
        let lb = UILabel()
        lb.text = "비밀번호 확인"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    lazy var passwordCheckTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호 확인"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeUi()
        textFieldSetting()
        
        signUp.backgroundColor = .systemGray5
        
        nameTextField.delegate = self
        emailAdressTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        
        navigationController?.navigationBar.tintColor = UIColor.black
    }
 
    func textFieldSetting() {
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.clearButtonMode = .always
        nameTextField.spellCheckingType = .no
        nameTextField.addLeftPadding()
        
        emailAdressTextField.autocapitalizationType = .none
        emailAdressTextField.autocorrectionType = .no
        emailAdressTextField.clearButtonMode = .always
        emailAdressTextField.spellCheckingType = .no
        emailAdressTextField.keyboardType = .emailAddress
        emailAdressTextField.addLeftPadding()
        
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.clearButtonMode = .always
        passwordTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addLeftPadding()
        
        passwordCheckTextField.autocapitalizationType = .none
        passwordCheckTextField.autocorrectionType = .no
        passwordCheckTextField.clearButtonMode = .always
        passwordCheckTextField.spellCheckingType = .no
        passwordCheckTextField.isSecureTextEntry = true
        passwordCheckTextField.addLeftPadding()
    }
    
    @objc private func membershipPressed() {
        let vc = ProfileMakeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeUi()
    }
    
}

extension MembershipViewController: UITextFieldDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        let isNameEmpty = nameTextField.text?.isEmpty ?? true
        let isEmailEmpty = emailAdressTextField.text?.isEmpty ?? true
        let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
        let isPasswordCheckEmpty = passwordCheckTextField.text?.isEmpty ?? true
        
        if !isNameEmpty && !isEmailEmpty && !isPasswordEmpty && !isPasswordCheckEmpty {
            signUp.backgroundColor = .mainColor
        } else {
            signUp.backgroundColor = .systemGray5
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        textField.text = currentText
        
        textFieldDidChange(textField)
        
        return false
    }
}


extension MembershipViewController {
    func makeUi() {
        name.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailAdress.translatesAutoresizingMaskIntoConstraints = false
        emailAdressTextField.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCheck.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckTextField.translatesAutoresizingMaskIntoConstraints = false
        signUp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            emailAdress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailAdress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailAdress.bottomAnchor.constraint(equalTo: emailAdressTextField.topAnchor, constant: 5),
            emailAdress.heightAnchor.constraint(equalToConstant: 30),
            
            emailAdressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailAdressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailAdressTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
            emailAdressTextField.heightAnchor.constraint(equalToConstant: 30),
            emailAdressTextField.heightAnchor.constraint(equalToConstant: 60),
            
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            password.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 5),
            password.heightAnchor.constraint(equalToConstant: 30),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: emailAdressTextField.bottomAnchor, constant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordCheck.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordCheck.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordCheck.bottomAnchor.constraint(equalTo: passwordCheckTextField.topAnchor, constant: 5),
            passwordCheck.heightAnchor.constraint(equalToConstant: 30),
            
            passwordCheckTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordCheckTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            passwordCheckTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordCheckTextField.heightAnchor.constraint(equalToConstant: 60),
            
            signUp.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            signUp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            signUp.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            signUp.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
