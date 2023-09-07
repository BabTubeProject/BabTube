//
//  ProfileMakeViewController.swift
//  BabTube
//
//  Created by 정기현 on 2023/09/04.
//

import UIKit

class ProfileMakeViewController: UIViewController {
    var newUserIndex: Int?
    private let picker = UIImagePickerController()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = UIColor(red: 235/255, green: 141/255, blue: 142/255, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)

        return imageView
    }()

    private lazy var profileChangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("프로필 사진 변경", for: .normal)
        btn.titleLabel?.font = .body
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()

    private lazy var nickName: UILabel = {
        let lb = UILabel()
        lb.text = "닉네임"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()

    private lazy var nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해주세요."
        tf.backgroundColor = .systemGray5
        tf.font = .body
        tf.textColor = .black
        tf.layer.cornerRadius = 10
        view.addSubview(tf)

        return tf
    }()

    private lazy var introduce: UILabel = {
        let lb = UILabel()
        lb.text = "자기소개"
        lb.font = .body
        lb.textColor = .black
        view.addSubview(lb)
        return lb
    }()

    private lazy var introduceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "안녕하세요"
        tf.backgroundColor = .systemGray5
        tf.font = .body
        tf.textColor = .black
        tf.layer.cornerRadius = 10
        view.addSubview(tf)

        return tf
    }()

    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = .mainColor
        btn.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)

        view.addSubview(btn)
        return btn
    }()

    @objc private func profileButtonPressed() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        textFieldSetting()
        picker.delegate = self
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }

    private func textFieldSetting() {
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

            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.clear.cgColor
            profileImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileMakeViewController {
    private func makeUI() {
        view.backgroundColor = UIColor.white

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileChangeButton.translatesAutoresizingMaskIntoConstraints = false
        nickName.translatesAutoresizingMaskIntoConstraints = false
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        introduce.translatesAutoresizingMaskIntoConstraints = false
        introduceTextField.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            profileChangeButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            profileChangeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileChangeButton.widthAnchor.constraint(equalToConstant: 110),
            profileChangeButton.heightAnchor.constraint(equalToConstant: 30),

            nickName.topAnchor.constraint(equalTo: profileChangeButton.bottomAnchor, constant: 40),
            nickName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            nickName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            nickName.heightAnchor.constraint(equalToConstant: 20),

            nickNameTextField.topAnchor.constraint(equalTo: nickName.bottomAnchor, constant: 4),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 30),

            introduce.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 24),
            introduce.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            introduce.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            introduce.heightAnchor.constraint(equalToConstant: 20),

            introduceTextField.topAnchor.constraint(equalTo: introduce.bottomAnchor, constant: 4),
            introduceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            introduceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            introduceTextField.heightAnchor.constraint(equalToConstant: 80),

            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            startButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    @objc private func startButtonClick() {
        if nickNameTextField.text != "" {
            guard let newNickName = nickNameTextField.text else { return }
            guard let newProfileImage = profileImageView.image else { return }
            guard let newUserIndex = newUserIndex else { return }
            do {
                try UserDataManager.shared.updateUserInfo(userIndex: newUserIndex, newNickname: newNickName, newImage: newProfileImage)
                print(UserDataManager.shared.users[newUserIndex].nickname!)
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false)
            } catch {
                print("프로필 저장 실패")
            }
        } else if nickNameTextField.text == "" {
            let alertController = UIAlertController(title: "닉네임을 입력해주세요", message: "닉네임을 입력해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    func changeToProfileEdit() {
        // UI는 메인 쓰레드에서 변경
        DispatchQueue.main.async {
            self.profileImageView.image = UIImage(systemName: "pencil")
            self.nickNameTextField.text = "홍준영"
            self.introduceTextField.text = "만나서 반갑습니다"
            self.startButton.setTitle("수정하기", for: .normal)
            self.startButton.removeTarget(self, action: #selector(self.profileButtonPressed), for: .touchUpInside)
            self.startButton.addTarget(self, action: #selector(self.moveBackMyPage), for: .touchUpInside)
        }
    }

    @objc func moveBackMyPage() {
        navigationController?.popViewController(animated: true)
    }
}
