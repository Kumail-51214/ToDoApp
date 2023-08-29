//
//  ViewController.swift
//  ToDoApp
//
//  Created by Muhammad Kumail on 8/28/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    var dataOfText:[String] = []
    
    let headingLabel:UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 26, weight: .medium)
        lbl.text = "To Do"
        return lbl
    }()
    
    let nextButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        return btn
    }()
    
    let tableView:UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemPurple
        return tv
    }()
    
    var tableLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        return lbl
    }()
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        view.backgroundColor = .systemPurple
        
        setupViews()
        registerCell()
        setProtocolsAndDelegates()
        nextControllerButton()
        fetchData()
        bindViews()
    }

    func setupViews() {
        
        view.addSubview(tableView)
        view.addSubview(headingLabel)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
        
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 50),
            
            nextButton.topAnchor.constraint(equalTo: headingLabel.topAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    func bindViews() {
        viewModel.didFetchedData = {
            self.dataOfText = self.viewModel.dataArray
            self.tableView.reloadData()
        }
    }
    func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setProtocolsAndDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func nextControllerButton() {
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    
    @objc func handleNext() {
        
        let controller = SecondViewController()
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func fetchData() {
        viewModel.fetchData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataOfText[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOfText.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            dataOfText.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
}

extension ViewController: PassData {
    func dataPassing(data: String) {
        self.dataOfText.append(data)
        tableView.reloadData()
    }
}

