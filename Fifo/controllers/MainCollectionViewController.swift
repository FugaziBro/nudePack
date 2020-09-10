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
    private var data:[String] = {
        var arr = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14",""]
        arr.append("15")
        return arr
    }()
    public var viewDelegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
    //MARK: OBJC
    
    public func completitionBlock(){
        self.data.removeAll { (element) -> Bool in
            element == ""
        }
        self.data.shuffle()
        self.data.append("")
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        
        cell.label.text = data[indexPath.item]
        
        return cell
    }
    
    //MARK: Check for end game
    
    func gameIsEnded(){
        if data == ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",""]{
            completitionBlock()
            smallAnimation(viewController: viewDelegate!)
            increaseScore()
        }
    }
    
    //MARK: Score increase
    func increaseScore(){
        viewDelegate!.score! += 100
    }
}

extension MainCollectionViewController: UICollectionViewDropDelegate, UICollectionViewDragDelegate{
    //MARK: Drop Delegate
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let start = coordinator.items.first?.sourceIndexPath else { return }
        guard let end = coordinator.destinationIndexPath else { return }
        if checkForAvailableMove(start: start, end: end){
            reorderItems(start: start, end: end)
        }
        gameIsEnded()
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
    
    //MARK: Helpers
    
    func reorderItems(start:IndexPath, end:IndexPath){
        let startValue = data[start.item]
        let endValue = data[end.item]
        
        data[start.item] = endValue
        data[end.item] = startValue
        print(data)
        collectionView.reloadData()
    }
    
    func checkForAvailableMove(start:IndexPath, end:IndexPath)->Bool{
        let cellIsNear={(start:IndexPath,end:IndexPath)->Bool in
            return ((start.item + 1 == end.item) && start.item != 3 && start.item != 7 && start.item != 11) ||
                ((start.item - 1 == end.item) && start.item != 4 && start.item != 8 && start.item != 12) ||
                (start.item + 4 == end.item) ||
                (start.item - 4 == end.item)
        }
        
        guard let endCell = collectionView.cellForItem(at: end) as? MainCollectionViewCell else { return false }
        return  cellIsNear(start,end) && endCell.label.text == ""
    }
}
