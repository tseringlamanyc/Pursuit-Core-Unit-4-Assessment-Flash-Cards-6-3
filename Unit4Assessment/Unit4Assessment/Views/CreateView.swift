//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray5
        tf.placeholder = "Enter title here"
        return tf
    }()
    
    public lazy var textView1: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemGray5
        return tv
    }()
    
    public lazy var textView2: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemGray5
        return tv
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
        setupTextField()
        setupTV1()
        setupTV2()
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.040)
        ])
    }
    
    private func setupTV1() {
        addSubview(textView1)
        textView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView1.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            textView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textView1.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupTV2() {
        addSubview(textView2)
        textView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView2.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 8),
            textView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textView2.heightAnchor.constraint(equalTo: textView1.heightAnchor)
        ])
    }
}
