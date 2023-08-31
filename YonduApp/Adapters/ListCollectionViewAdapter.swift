//
//  ListTableViewAdapter.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class ListCollectionViewAdapter: NSObject {
    
    private let REUSE_IDENTIFIER = ImageTextCollectionViewCell.className()
    private weak var collectionView: UICollectionView?
    private weak var delegate: ListCollectionViewAdapterDelegate?
    private var data: [Rewards]?
    
    init(collectionView: UICollectionView, delegate: ListCollectionViewAdapterDelegate) {
        self.delegate = delegate
        self.collectionView = collectionView
        super.init()
        prepare(collectionView)
    }
    
    func set(data: [Rewards]) {
        self.data = data
        self.collectionView?.reloadData()
    }
    
}

private extension ListCollectionViewAdapter {
    func prepare(_ collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: ImageTextCollectionViewCell.className(), bundle: Bundle.main),
                                forCellWithReuseIdentifier: REUSE_IDENTIFIER)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ListCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath) as? ImageTextCollectionViewCell
        
        if let item = data?[indexPath.row] {
            cell?.display(item)
        }
        
        
        return cell!
    }
}

extension ListCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = data?[indexPath.row] else { return }
        
        delegate?.didSelect(item)
    }
}

extension ListCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 320)
    }
}

protocol ListCollectionViewAdapterDelegate: AnyObject {
    func didSelect(_ item: Rewards)
}
