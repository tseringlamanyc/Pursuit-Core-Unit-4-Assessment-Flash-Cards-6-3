//
//  TabBar.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    private var cardsVC: CardsVC = {
       let vc = CardsVC()
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "creditcard.fill"), tag: 0)
        return vc
    }()
    
    private var createVC: CreateVC = {
       let vc = CreateVC()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus.square.fill"), tag: 1)
        return vc
    }()

    private var searchVC: SearchVC = {
        let vc = SearchVC()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [cardsVC, createVC, searchVC]
    }
}
