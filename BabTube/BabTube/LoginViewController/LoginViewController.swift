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
        guard let userEmail = emailTextField.text, !userEmail.isEmpty else {
            let titles = "이메일을 입력해주세요"
            let messages = "이메일을 입력해주세요"
            failAlert(title: titles, message: messages)
            return
        }
        guard let userPassword = passwordTextField.text, !userPassword.isEmpty else {
            let titles = "비밀번호를 입력해주세요"
            let messages = "비밀번호를 입력해주세요"
            failAlert(title: titles, message: messages)
            return
        }
        // 이메일 유효성 검사
        if !emailTypeCheck(email: userEmail) {
            let titles = "유효하지 않은 이메일"
            let messages = "유효한 이메일 주소를 입력해주세요."
            failAlert(title: titles, message: messages)
            return
        }
            
        // 사용자 데이터에서 이메일과 비밀번호를 확인하여 로그인
        if let user = UserDataManager.shared.users.first(where: { $0.userID == userEmail && $0.password == userPassword }) {
            print("로그인 성공")
            UserDataManager.shared.loginUser = user
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
               
        } else {
            let titles = "로그인 실패"
            let messages = "이메일 주소 또는 비밀번호가 일치하지 않습니다."
            failAlert(title: titles, message: messages)
        }
        print(UserDataManager.shared.loginUser ?? "로그인 실패")
    }

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

    @objc private func newMembershipClick() {
        print("pressed")
        let completeVC = MembershipViewController()
        navigationController?.pushViewController(completeVC, animated: false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""

        textField.text = currentText

        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = .mainColor
        } else {
            loginButton.backgroundColor = .systemGray5
        }
        return false
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
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            babtubeIcon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
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

            loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
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
