//
//  MembershipViewController.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/04.
//

import UIKit

class MembershipViewController: UIViewController {
    private lazy var signUp: UIButton = {
        let btn = UIButton()
        btn.setTitle("가입하기", for: .normal)
        btn.backgroundColor = .mainColor
        btn.addTarget(self, action: #selector(membershipPressed), for: .touchUpInside)
        
        view.addSubview(btn)
        return btn
    }()
    
    private lazy var titles: UILabel = {
        let lb = UILabel()
        lb.text = "회원가입"
        lb.font = .title3
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    private lazy var name: UILabel = {
        let lb = UILabel()
        lb.text = "이름"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "홍길동"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()

    private lazy var emailAdress: UILabel = {
        let lb = UILabel()
        lb.text = "이메일주소"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    private lazy var emailAdressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "babtube@gmail.com"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()

    private lazy var password: UILabel = {
        let lb = UILabel()
        lb.text = "비밀번호"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "영문,숫자,특수문자"
        tf.font = .body
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 10
        view.addSubview(tf)
        return tf
        
    }()

    private lazy var passwordCheck: UILabel = {
        let lb = UILabel()
        lb.text = "비밀번호 확인"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()
    
    private lazy var passwordCheckTextField: UITextField = {
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
        if nameTextField.text != "" && emailAdressTextField.text != "" && passwordTextField.text != "" && passwordTextField.text == passwordCheckTextField.text {
            guard let newName = nameTextField.text else { return }
            guard let newEmail = emailAdressTextField.text else { return }
            guard let newPassword = passwordTextField.text else { return }
            
            if !emailTypeCheck(email: newEmail) {
                let titles = "잘못된 이메일형식"
                let messages = "이메일 형식으로 다시 작성해주세요."
                failAlert(title: titles, message: messages)
            }
            
            if UserDataManager.shared.users.contains(where: { $0.userID == newEmail }) {
                let titles = "이미 사용 중인 이메일"
                let messages = "이미 사용 중인 이메일 주소입니다. 다른 이메일 주소를 입력해주세요."
                failAlert(title: titles, message: messages)
            } else {
                let newUser = UserData(name: newName, userID: newEmail, password: newPassword)
                
                UserDataManager.shared.addUser(userData: newUser)
                if let newUserIndex = UserDataManager.shared.users.firstIndex(where: { $0.userID == newEmail }) {
                    let vc = ProfileMakeViewController()
                    vc.newUserIndex = newUserIndex
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: false)
                }
            }
        } else if passwordTextField.text != passwordCheckTextField.text {
            let titles = "비밀번호 불일치"
            let messages = "입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다."
            failAlert(title: titles, message: messages)
        } else if emailAdressTextField.text == "" {
            let titles = "이메일을 입력해주세요"
            let messages = "이메일을 입력해주세요"
            failAlert(title: titles, message: messages)
        } else if nameTextField.text == "" {
            let titles = "이름을 입력해주세요"
            let messages = "이름을 입력해주세요"
            failAlert(title: titles, message: messages)
        }
        
        print(UserDataManager.shared.users)
    }

    // 입력이 안되거나 비밀번호가 틀렸을때의 Alert창
    private func failAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    // 이메일 유효성 검사
    private func emailTypeCheck(email: String) -> Bool {
        let emailType = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailType)
        return emailCheck.evaluate(with: email)
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
