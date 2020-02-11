//
//  SearchView.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    public lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search for cards"
        return searchBar
    }()
    
    public lazy var searchCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray
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
        setupSearchBar()
        setupCV()
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupCV() {
        addSubview(searchCV)
        searchCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchCV.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            searchCV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchCV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchCV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
