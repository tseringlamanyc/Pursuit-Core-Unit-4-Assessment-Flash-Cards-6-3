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
    
    private var userCards = [Card]() {
        didSet {
            cardsView.cardsCV.reloadData()
            if userCards.isEmpty {
                cardsView.cardsCV.backgroundView = EmptyView(title: "Cards", message: "No cards made yet")
            } else {
                cardsView.cardsCV.backgroundView = nil 
            }
        }
    }
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func loadView() {
        view = cardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserCards()
        navigationItem.title = "Your Cards"
        cardsView.cardsCV.dataSource = self
        cardsView.cardsCV.delegate = self
        cardsView.cardsCV.register(CardsCell.self, forCellWithReuseIdentifier: "cardsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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

extension CardsVC: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadUserCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadUserCards()
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
        let aCard = userCards[indexPath.row]
        cell.userCard = aCard
        cell.dataPersistence = dataPersistence
        cell.delegate = self
        cell.updateUI(card: aCard)
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

extension CardsVC: CardsCellDelegate {
    
    func didPress(cell: CardsCell, card: Card) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
            self.delete(card: card)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func delete(card: Card) {
        guard let index = userCards.firstIndex(of: card) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
            
            UIView.transition(with: cardsView, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
            }) { (done) in
                self.showAlert(title: "Success", message: "Card deleted")
            }
            } catch {
            showAlert(title: "Error", message: "Could delete due to \(error)")
            print("couldnt delete")
        }
    }
}

