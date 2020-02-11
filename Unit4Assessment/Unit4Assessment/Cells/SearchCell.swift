//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    public lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.alpha = 0
        return label
    }()
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        button.alpha = 1
        return button
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
        setupButton()
        setupAnswer()
        setupTitle()
    }
    
    private func setupButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.widthAnchor)
        ])
    }
    
    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupAnswer() {
        addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    public func updateUI(card: Card) {
        titleLabel.text = card.cardTitle
        answerLabel.text = card.facts.joined(separator: " ")
    }

}
