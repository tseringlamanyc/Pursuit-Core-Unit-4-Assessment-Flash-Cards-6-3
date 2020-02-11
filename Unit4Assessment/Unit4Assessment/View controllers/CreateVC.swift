//
//  CreateVC.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateVC: UIViewController {
    
    private let createView = CreateView()
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationItem.title = "Create Quiz"
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: nil)
        tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        view.backgroundColor = .systemBackground
    }
    
}
