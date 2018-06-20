//
//  CollectionDataSource.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol ViewModelizedCell: ReusableCell {
    associatedtype T
    
    var viewModel: T? { get set }
}

class CollectionDataSource<Provider: CollectionDataProvider, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout where Cell: ViewModelizedCell, Provider.T == Cell.T {
        
    var provider: Provider?
    private var sizingCell = Cell()
    
    // MARK: - UICollectionView Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let provider = provider else {
            return 0
        }
        
        return provider.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let provider = provider else {
            return 0
        }
        
        return provider.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError()
        }
        
        if let item = provider?.item(at: indexPath) {
            cell.viewModel = item
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        sizingCell.contentView.frame.size.width = width
        
        let item = provider?.item(at: indexPath)
        sizingCell.viewModel = item
        
        sizingCell.contentView.setNeedsLayout()
        sizingCell.contentView.layoutIfNeeded()
        
        let height = sizingCell.contentView.systemLayoutSizeFitting(CGSize(width: width, height: UILayoutFittingCompressedSize.height)).height
        
        sizingCell.prepareForReuse()
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
