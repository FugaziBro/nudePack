//
//  MainCollectionViewCell.swift
//  Fifo
//
//  Created by Бакулин Семен Александрович on 08.09.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    public let label = UILabel(frame: .zero)
    private var isAvailable = false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = #colorLiteral(red: 0.0004504821554, green: 0.01128888596, blue: 0.1788523495, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 0.5822705626, green: 0.07456538826, blue: 0.1769841611, alpha: 1)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
