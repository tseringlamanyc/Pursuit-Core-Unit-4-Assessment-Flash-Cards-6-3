//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol SearchCellDelegate: AnyObject {
    func didPress(cell: SearchCell)
}

class SearchCell: UICollectionViewCell {
    
    weak var delegate: SearchCellDelegate?
    
    private lazy var longPress: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(gesture:)))
        return gesture
    }()
    
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
    
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        button.alpha = 1
        return button
    }()
    
    private var isTitle = true
    
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
        addGestureRecognizer(longPress)
    }
    
    private func setupButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalTo: addButton.widthAnchor)
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
    
    @objc
    private func didLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isTitle.toggle()
        self.animate()
    }
    
    private func animate() {
        let duration: Double = 1.0
        if isTitle {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 1.0
                self.addButton.alpha = 1.0
                self.answerLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.titleLabel.alpha = 0.0
                self.addButton.alpha = 0.0
                self.answerLabel.alpha = 1.0
            }, completion: nil)
        }
    }
    
    public func updateUI(card: Card) {
        titleLabel.text = card.cardTitle
        answerLabel.text = card.facts.joined(separator: " ")
    }
    
}
