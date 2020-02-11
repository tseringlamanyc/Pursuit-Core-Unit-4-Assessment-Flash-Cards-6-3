//
//  ViewController.swift
//  Unit4Assessment
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsVC: UIViewController {
    
    private let cardsView = CardsView()
    
    private var userCards = [UserCards]() {
        didSet {
            cardsView.cardsCV.reloadData()
            if userCards.isEmpty {
                cardsView.cardsCV.backgroundView = EmptyView(title: "Cards", message: "No cards made yet")
            } else {
                cardsView.cardsCV.backgroundView = nil 
            }
        }
    }
    
    public var dataPersistence: DataPersistence<UserCards>!
    
    override func loadView() {
        view = cardsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadUserCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Your Cards"
        cardsView.cardsCV.dataSource = self
        cardsView.cardsCV.delegate = self
        cardsView.cardsCV.register(CardsCell.self, forCellWithReuseIdentifier: "cardsCell")
        loadUserCards()
    }
    
    private func loadUserCards() {
        do {
            userCards = try dataPersistence.loadItems()
        } catch {
            print("couldnt load items")
        }
    }
}

extension CardsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath) as? CardsCell else {
            fatalError()
        }
        cell.updateUI(card: userCards[indexPath.row])
        cell.backgroundColor = .systemBackground
        return cell
    }
}

extension CardsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let maxSize = UIScreen.main.bounds.size
           let itemWidth: CGFloat = maxSize.width
           return CGSize(width: itemWidth, height: 264)
       }
}

