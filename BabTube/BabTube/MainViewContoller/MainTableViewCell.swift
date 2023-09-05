//
//  MainTableViewCell.swift
//  BabTube
//
//  Created by Hyunwoo Lee on 2023/09/04.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let id = "MainTableViewCell"
    static let cellHeight = 150.0

    var list: [String] = ["1", "2", "3","4","5","6"]
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width:200, height: cellHeight)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(MainCVCell.self, forCellWithReuseIdentifier: MainCVCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.collectionView.dataSource = self
        MainCVAddSubView()
        MainCVAutoLayout()
    }
}
extension MainTableViewCell {
    private func MainCVAddSubView() {
        self.contentView.addSubview(self.collectionView)
    }
    
    private func MainCVAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

extension MainTableViewCell: UICollectionViewDataSource {
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.list.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCVCell.id, for: indexPath) as! MainCVCell
      cell.contentView.backgroundColor = UIColor.green
      cell.lbl.text = list[indexPath.row]
      
      return cell
    }
  }


