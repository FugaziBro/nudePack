//
//  ViewController.swift
//  Fifo
//
//  Created by Бакулин Семен Александрович on 08.09.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionController = MainCollectionViewController(collectionViewLayout: flowLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayoutSetup()
        viewSetup()
    }
    
    func flowLayoutSetup(){
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = .zero
    }
    
    func viewSetup(){
        guard let collection = collectionController.collectionView else {return}
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collection.heightAnchor.constraint(equalToConstant: 300),
            collection.widthAnchor.constraint(equalTo: collection.heightAnchor)
        ])
    }
    
}

