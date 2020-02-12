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
        
        let title = createView.textField.text
        let fact1 = createView.textView1.text
        let fact2 = createView.textView2.text
        
        
        if title?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 ||  fact1?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 ||  fact2?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            sender.isEnabled = false
            showAlert(title: "Fail", message: "Please fill all fields") }
              else
            if title?.isEmpty == true || fact1?.isEmpty == true || fact2?.isEmpty == true {
                sender.isEnabled = false
                showAlert(title: "Fail", message: "Please fill all fields")
            } else {
                let userCreated = Card(cardTitle: createView.textField.text!, facts: [createView.textView1.text, createView.textView2.text])
                createView.textView1.resignFirstResponder()
                createView.textView2.resignFirstResponder()
                createView.textField.resignFirstResponder()
                if dataPersistence.hasItemBeenSaved(userCreated) {
                    showAlert(title: "Fail", message: "This card has already been created")
                } else {
                    do {
                        try dataPersistence.createItem(userCreated)
                        showAlert(title: "Sucess", message: "Card created")
                    } catch {
                        print("couldnt save")
                    }
                }
        }
        sender.isEnabled = true
    }
    
    
    
    @objc
    private func cancelPreseed(sender: UIBarButtonItem) {
        createView.textField.text = ""
        createView.textView2.text = ""
        createView.textView1.text = ""
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
