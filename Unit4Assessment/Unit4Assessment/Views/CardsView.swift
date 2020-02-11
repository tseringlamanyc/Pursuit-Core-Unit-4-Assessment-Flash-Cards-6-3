//
//  CardsView.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardsView: UIView {
    
    public lazy var cardsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray5
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupCV()
    }
    
    private func setupCV() {
        addSubview(cardsCV)
        cardsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardsCV.topAnchor.constraint(equalTo: topAnchor),
            cardsCV.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardsCV.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardsCV.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
