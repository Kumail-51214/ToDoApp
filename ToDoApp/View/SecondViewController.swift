//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by Muhammad Kumail on 8/28/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

protocol PassData {
    func dataPassing(data:String)
    
}

class SecondViewController: UIViewController {

    let textField:UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 18, weight: .medium)
        tf.placeholder = "Add Text"
        tf.backgroundColor = .white
        return tf
    }()
    
    let saveButton:UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save", for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemBrown
        return btn
    }()
        
    var delegate:PassData?
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint

        setupViews()
        returnToViewController()
        
    }
    
    func setupViews() {
        
        view.addSubview(textField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
        
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 60),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 80),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func returnToViewController() {
        saveButton.addTarget(self, action: #selector(handleReturn), for: .touchUpInside)
    }
    
    @objc func handleReturn() {
        let newData = textField.text ?? "nil"
        self.delegate?.dataPassing( data: newData)
        viewModel.postData(data: newData)
        self.navigationController?.popViewController(animated: true)
    }
}

