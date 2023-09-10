//
//  MainTableViewCell.swift
//  BabTube
//
//  Created by Hyunwoo Lee on 2023/09/04.
//

import UIKit
//cell delegate protocol
protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(section: Int, index: Int)
}

class MainTVCell: UITableViewCell {
    
    //위임자 (ViewController와 강한 참조 순환이 발생하기 때문에 weak로 선언)
    weak var cellDelegate: CollectionViewCellDelegate?
    private var searchItemList: [SearchItems]?
    private var section: Int?
    //cell 식별자
    static let id = "MainTableViewCell"
    
    //cell 높이 설정
    static let cellHeight = 150.0
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset.top = 0
        layout.sectionInset.left = 16
        layout.sectionInset.bottom = 0
        layout.sectionInset.right = 16
        layout.itemSize = .init(width:267, height: cellHeight)
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
        self.collectionView.delegate = self
        mainCVAddSubView()
        mainCVAutoLayout()
    }
}

extension MainTVCell {
    
    //TableView에 컬렉션뷰 추가
    private func mainCVAddSubView() {
        self.contentView.addSubview(self.collectionView)
    }
    
    //CollectionView 레이아웃
    private func mainCVAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    func updateUI(items: [SearchItems], section: Int) {
        searchItemList = items
        self.section = section
        collectionView.reloadData()
    }
}

extension MainTVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    //CollectionView 보여줄 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchItemList?.count ?? 0
    }
    
    //CollectionView 셀에 보여줄 아이템
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCVCell.id, for: indexPath) as? MainCVCell else {
            return UICollectionViewCell()
        }
        cell.contentView.backgroundColor = UIColor.green
        guard let searchItemList,
              let snippet = searchItemList[indexPath.item].snippet else { return cell }
        cell.updateCellImage(snippet: snippet)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,  didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCVCell.id, for: indexPath) as! MainCVCell
        if let cellDelegate = cellDelegate,
           let section {
            cellDelegate.collectionView(section: section, index: indexPath.item)
        }
    }
}

