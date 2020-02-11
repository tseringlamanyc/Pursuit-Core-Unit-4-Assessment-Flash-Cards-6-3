//
//  TabBar.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    private lazy var cardsVC: CardsVC = {
       let vc = CardsVC()
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "creditcard.fill"), tag: 0)
        vc.navigationItem.title = "Your cards"
        return vc
    }()
    
    private lazy var createVC: CreateVC = {
       let vc = CreateVC()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus.square.fill"), tag: 1)
        vc.navigationItem.title = "Create here"
        return vc
    }()

    private lazy var searchVC: SearchVC = {
        let vc = SearchVC()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        vc.navigationItem.title = "Search"
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [cardsVC, createVC, searchVC]
    }
}
