//
//  EndGameStackView.swift
//  Fifo
//
//  Created by Бакулин Семен Александрович on 09.09.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class EndGameStackView: UIStackView {
    private let label = UILabel()
    private let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Setup
    func setupView(){
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .center
        self.spacing = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7960784314, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7960784314, blue: 1, alpha: 1)
        
        label.layer.borderColor = CGColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5))
        label.layer.borderWidth = 1
        label.text = "Do you want to start new game?"
        label.textAlignment = .center
        label.layer.cornerRadius = 25
        label.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        label.clipsToBounds = true
        label.font = UIFont(name: "Futura", size: 18)
        
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        button.clipsToBounds = true
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Futura", size: 32)
        button.layer.borderColor = CGColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5))
        button.layer.borderWidth = 1
        
        self.addArrangedSubview(label)
        self.addArrangedSubview(button)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 150),
            label.widthAnchor.constraint(equalToConstant: 280),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.widthAnchor.constraint(equalTo: label.widthAnchor),
        ])
        
    }
}
