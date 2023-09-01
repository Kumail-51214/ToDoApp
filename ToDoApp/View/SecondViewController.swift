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
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10
        tf.placeholder = "Add Text"
        tf.backgroundColor = .white
        return tf
    }()
    
    let saveButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Return", for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemBrown
        return btn
    }()
    
    let backButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    var delegate:PassData?
    let viewModel = ViewModel()
    
    var textFieldCenterYConstraint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        setupViews()
        returnToViewController()
        backToViewController()
        addPadding()
        notificationObserver()
        
    }
    func setupViews() {
        
        view.addSubview(textField)
        view.addSubview(saveButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 60),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 80),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        textFieldCenterYConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        textFieldCenterYConstraint?.isActive = true
        
    }
    func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide)))
    }
    
    @objc func keyboardWillShow(){
        
        textFieldCenterYConstraint?.isActive = false
        textFieldCenterYConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        textFieldCenterYConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(){
        textField.resignFirstResponder()
        textFieldCenterYConstraint?.isActive = false
        textFieldCenterYConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        textFieldCenterYConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func returnToViewController() {
        saveButton.addTarget(self, action: #selector(handleReturn), for: .touchUpInside)
    }
    
    func backToViewController(){
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    @objc func handleReturn() {
        let newData = textField.text ?? "nil"
        self.delegate?.dataPassing( data: newData)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
}

