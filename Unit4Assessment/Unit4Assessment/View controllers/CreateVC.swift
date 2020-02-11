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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        
//         if createView.textField.text?.isEmpty == false && createView.textView1.text.isEmpty == false && createView.textView2.text.isEmpty == false {
//            sender.isEnabled = true
            userCard = UserCards(title: createView.textField.text!, description: createView.textView1.text! + createView.textView2.text!)
            do {
                try dataPersistence.createItem(userCard!)
                showAlert(title: "Sucess", message: "Card created")
            } catch {
                print("couldnt save")
            }
//         } else {
//            showAlert(title: "Fail", message: "Please fill all 3 sections")
//            sender.isEnabled = false
//        }
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
