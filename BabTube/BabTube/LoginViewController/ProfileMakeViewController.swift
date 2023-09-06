//
//  ProfileMakeViewController.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/04.
//

import UIKit

class ProfileMakeViewController: UIViewController {
    let picker = UIImagePickerController()
    lazy var profileView: UIView = {
        let views = UIView()
        views.backgroundColor = .systemGray5
        views.tintColor = .white
        views.addSubview(profileImageView)
        views.layer.cornerRadius = 30

        view.addSubview(views)

        return views
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        view.addSubview(imageView)

        return imageView
    }()

    lazy var profileChangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("프로필 사진 변경", for: .normal)
        btn.titleLabel?.font = .body
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()

    lazy var nickName: UILabel = {
        let lb = UILabel()
        lb.text = "닉네임"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()

    lazy var nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해주세요."
        tf.backgroundColor = .systemGray5
        tf.font = .body
        tf.textColor = .black
        tf.layer.cornerRadius = 10
        view.addSubview(tf)

        return tf
    }()

    lazy var introduce: UILabel = {
        let lb = UILabel()
        lb.text = "자기소개"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()

    lazy var introduceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "안녕하세요"
        tf.backgroundColor = .systemGray5
        tf.font = .body
        tf.textColor = .black
        tf.layer.cornerRadius = 10
        view.addSubview(tf)

        return tf
    }()

    lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = .mainColor
        btn.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)

        view.addSubview(btn)
        return btn
    }()

    @objc func profileButtonPressed() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUi()
        textFieldSetting()
        picker.delegate = self
    }

    func textFieldSetting() {
        nickNameTextField.autocapitalizationType = .none
        nickNameTextField.autocorrectionType = .no
        nickNameTextField.clearButtonMode = .always
        nickNameTextField.spellCheckingType = .no
        nickNameTextField.addLeftPadding()

        introduceTextField.autocapitalizationType = .none
        introduceTextField.autocorrectionType = .no
        introduceTextField.clearButtonMode = .always
        introduceTextField.spellCheckingType = .no
        introduceTextField.addLeftPadding()
    }
}

extension ProfileMakeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] {
            profileImageView.image = image as? UIImage

            
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.clear.cgColor
            profileImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileMakeViewController {
    func makeUi() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileChangeButton.translatesAutoresizingMaskIntoConstraints = false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        nickName.translatesAutoresizingMaskIntoConstraints = false
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        introduce.translatesAutoresizingMaskIntoConstraints = false
        introduceTextField.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),

            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 70),
            profileView.heightAnchor.constraint(equalToConstant: 70),

            profileChangeButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            profileChangeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileChangeButton.widthAnchor.constraint(equalToConstant: 110),
            profileChangeButton.heightAnchor.constraint(equalToConstant: 30),

            nickName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nickName.bottomAnchor.constraint(equalTo: nickNameTextField.topAnchor, constant: 5),
            nickName.heightAnchor.constraint(equalToConstant: 30),

            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nickNameTextField.topAnchor.constraint(equalTo: profileChangeButton.bottomAnchor, constant: 50),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 30),

            introduce.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            introduce.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            introduce.bottomAnchor.constraint(equalTo: introduceTextField.topAnchor, constant: 5),
            introduce.heightAnchor.constraint(equalToConstant: 30),

            introduceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            introduceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            introduceTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 50),
            introduceTextField.heightAnchor.constraint(equalToConstant: 80),

            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            startButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    @objc private func startButtonClick() {
        print("pressed")
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
