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
    private let reloadButton = UIButton(type: .custom)
    private let scoreLabel = UILabel()
    public var score:Int?{
        willSet{
            UserDefaults.standard.set(newValue, forKey: "score")
            scoreLabel.text = "Your score: \(newValue!)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score = userDefaultsInit()
        flowLayoutSetup()
        viewsSetup()
        setupReloadButton()
        collectionController.viewDelegate = self
    }
    
    //MARK: Setup FlowLayout
    
    func flowLayoutSetup(){
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = .zero
    }
    
    //MARK: Setup collectionView
    
    func viewsSetup(){
        guard let collection = collectionController.collectionView else {return}
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collection.heightAnchor.constraint(equalToConstant: 320),
            collection.widthAnchor.constraint(equalTo: collection.heightAnchor)
        ])
        
        scoreLabel.font = UIFont(name: "Futura", size: 24)
        scoreLabel.text = "Your score: \(score!)"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.bottomAnchor.constraint(equalTo: collection.topAnchor, constant: -20),
            scoreLabel.centerXAnchor.constraint(equalTo: collection.centerXAnchor),
        ])
    }
    
    func setupReloadButton(){
        reloadButton.setImage(UIImage(named: "reload"), for: .normal)
        reloadButton.alpha = 0.75
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reloadButton)
        NSLayoutConstraint.activate([
            reloadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            reloadButton.trailingAnchor.constraint(equalTo: collectionController.collectionView.trailingAnchor,constant: 10),
            reloadButton.heightAnchor.constraint(equalToConstant: 50),
            reloadButton.widthAnchor.constraint(equalTo: reloadButton.heightAnchor),
        ])
        reloadButton.addTarget(self, action: #selector(viewCollectionReloadData), for: .touchUpInside)
    }
    
    //MARK: userDefaults
    
    func userDefaultsInit()->Int{
        if UserDefaults.standard.object(forKey: "score") == nil{
            UserDefaults.standard.set(0, forKey: "score")
        }
        return UserDefaults.standard.object(forKey: "score") as! Int
    }
    
    //MARK: objc
    
    @objc func viewCollectionReloadData(){
        collectionController.completitionBlock()
        smallAnimation(viewController: self)
    }
}

