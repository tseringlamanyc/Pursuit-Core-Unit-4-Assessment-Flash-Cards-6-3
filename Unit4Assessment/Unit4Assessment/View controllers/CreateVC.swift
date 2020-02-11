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
    
    public var userCard: UserCards?
    
    public var dataPersistence: DataPersistence<UserCards>!
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Quiz"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(makeCard(sender:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPreseed(sender:)))
        view.backgroundColor = .systemBackground
         createView.textField.delegate = self
        createView.textView1.delegate = self
        createView.textView2.delegate = self
    }
    
    @objc
    private func makeCard (sender: UIBarButtonItem) {
        userCard = UserCards(title: createView.textField.text!, description: createView.textView1.text! + createView.textView2.text!)
        do {
            try dataPersistence.createItem(userCard!)
            showAlert(title: "Sucess", message: "Card created")
        } catch {
            print("couldnt save")
        }
    }
    
    @objc
    private func cancelPreseed(sender: UIBarButtonItem) {
       
    }
}

extension CreateVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        userCard?.title = textField.text ?? "no title"
        return true
    }
}

extension CreateVC: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        userCard?.description = textView.text ?? "no description"
        return true 
    }
}
