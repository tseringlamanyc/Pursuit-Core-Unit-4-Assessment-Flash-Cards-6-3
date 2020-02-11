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
        guard !searchText.isEmpty else {
            loadCards()
            return
        }
        allCards = allCards.filter {$0.cardTitle.lowercased().contains(searchText.lowercased())}
    }
}
