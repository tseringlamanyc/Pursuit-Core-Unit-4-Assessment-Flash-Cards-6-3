//
//  SearchVC.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchVC: UIViewController {
    
    private var searchView = SearchView()
    
    private var allCards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.searchCV.reloadData()
            }
        }
    }
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        searchView.searchCV.dataSource = self
        searchView.searchCV.delegate = self
        searchView.searchCV.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
        searchView.searchBar.delegate = self
        loadCards()
    }
    
    private func loadCards() {
        guard let fileURL = Bundle.main.url(forResource: "cards", withExtension: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let cardData = Card.getCards(from: data)
            allCards = cardData
        } catch {
            print("nope")
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError()
        }
        let aCard = allCards[indexPath.row]
        cell.updateUI(card: aCard)
        cell.delegate = self 
        cell.aCard = aCard
        cell.backgroundColor = .systemBackground
        return cell
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        return CGSize(width: itemWidth, height: 264)
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.resignFirstResponder()
        guard !searchText.isEmpty else {
            loadCards()
            return
        }
        allCards = allCards.filter {$0.cardTitle.lowercased().contains(searchText.lowercased())}
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchView.searchBar.isFirstResponder {
        searchView.searchBar.resignFirstResponder()
      }
    }
}

extension SearchVC: SearchCellDelegate {
    
    func didPress(card: Card) {
        if dataPersistence.hasItemBeenSaved(card) {
            showAlert(title: "Error", message: "This card has already been saved")
        } else {
            saveCard(card: card)
        }
    }
    
    private func saveCard(card: Card) {
        do {
            try dataPersistence.createItem(card)
            showAlert(title: "Success", message: "Card added locally to your phone")
        } catch {
            showAlert(title: "Fail", message: "Couldnt save this card")
        }
    }
}
