//
//  MainCollectionViewController.swift
//  Fifo
//
//  Created by Бакулин Семен Александрович on 08.09.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    private var data:[Int] = [Int](0...8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
    
        cell.label.text = String(data[indexPath.item])
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension MainCollectionViewController: UICollectionViewDropDelegate, UICollectionViewDragDelegate{
    
    //MARK: Drop Delegate
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let start = coordinator.items.first?.sourceIndexPath else { return }
        guard let end = coordinator.destinationIndexPath else { return }
    
        let startValue = data[start.item]
        let endValue = data[end.item]
        
        data[start.item] = endValue
        data[end.item] = startValue
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
    }
    //MARK: - Drag Delegate
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let provider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: provider)
        dragItem.localObject =  data[indexPath.item]
        return [dragItem]
    }
}
