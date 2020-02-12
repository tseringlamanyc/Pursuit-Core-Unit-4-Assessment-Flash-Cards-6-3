//
//  CardsCell.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol CardsCellDelegate: AnyObject {
    func didPress(cell: CardsCell, card: Card)
}

class CardsCell: UICollectionViewCell {
    
    weak var delegate: CardsCellDelegate?
    
    public var userCard: Card!
    
    private lazy var longPress: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(gesture:)))
        return gesture
    }()
        
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "What is ...?"
        label.alpha = 1
        return label
    }()
    
    public lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "slflsjfljslfjsfjsdf;sjf;ljs;lfj;lsdjf;sdjflsjlf;jslfjksdjfl;sjfl;sjfdl;jsd;lfjsdjfl;"
        label.alpha = 0
        return label
    }()
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
        button.alpha = 1
        button.addTarget(self, action: #selector(moreButton(sender:)), for: .touchUpInside)
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
    
    private var isTitle = true
    
    private func commonInit() {
        setupTitle()
        setupAnswer()
        setupButton()
        addGestureRecognizer(longPress)
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
    
    @objc
    private func didLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isTitle.toggle()
        self.animate()
    }
    
    @objc
    private func moreButton(sender: UIButton) {
        delegate?.didPress(cell: self, card: userCard)
    }
    
    private func animate() {
        let duration: Double = 1.0
        if isTitle {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 1.0
                self.moreButton.alpha = 1.0
                self.answerLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.titleLabel.alpha = 0.0
                self.moreButton.alpha = 0.0
                self.answerLabel.alpha = 1.0
            }, completion: nil)
        }
    }
    
    public func updateUI (card: Card) {
        titleLabel.text = card.cardTitle
        answerLabel.text = card.facts.joined(separator: " ")
    }
}
