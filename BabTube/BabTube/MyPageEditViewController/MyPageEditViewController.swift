//
//  MyPageEditViewController.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/06.
//

import UIKit

class MyPageEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor(red: 235, green: 141, blue: 142, alpha: 1)
        view.addSubview(imageView)

        return imageView
    }()

    lazy var profileChangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("프로필 사진 변경", for: .normal)
        btn.titleLabel?.font = .body
        btn.setTitleColor(UIColor.mainColor, for: .normal)
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
