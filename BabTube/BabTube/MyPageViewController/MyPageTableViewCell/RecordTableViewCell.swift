//
//  RecordTableViewCell.swift
//  BabTube
//
//  Created by Junyoung_Hong on 2023/09/04.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    // Cell 식별자
    static let identifier = "RecordTableViewCellRecordTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var recordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "시청 기록"
        label.font = .title3
        label.textColor = UIColor.black
        return label
    }()
    
    var recordCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RecordCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
        
        recordCollectionView.dataSource = self
        recordCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordTableViewCell {
    
    private func addContentView() {
        contentView.addSubview(recordLabel)
        contentView.addSubview(recordCollectionView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            recordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            recordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            recordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            recordCollectionView.topAnchor.constraint(equalTo: recordLabel.bottomAnchor, constant: 8),
            recordCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recordCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            recordCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}

extension RecordTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.identifier, for: indexPath) as? RecordCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension RecordTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // CollectionView Cell의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 178, height: 100)
    }
    
    // CollectionViewCell 사이의 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // CollectionViewCell 섹션의 마진 값 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
