//
//  CreateVC.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateVC: UIViewController {
    
    public let createView = CreateView()
    
    public var userCard: Card?
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func loadView() {
        view = createView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Quiz"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(makeCard(sender:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(cancelPreseed(sender:)))
        view.backgroundColor = .systemBackground
        createView.textField.delegate = self
        createView.textView1.delegate = self
        createView.textView2.delegate = self
    }
    
    @objc
    private func makeCard (sender: UIBarButtonItem) {
        
       
        
    }
    
    
    @objc
    private func cancelPreseed(sender: UIBarButtonItem) {
      
    }
}

extension CreateVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateVC: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
