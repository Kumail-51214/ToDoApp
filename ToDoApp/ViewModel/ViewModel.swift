//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Muhammad Kumail on 8/28/23.
//

import UIKit
import FirebaseFirestore

class ViewModel {
    
    var dataArray: [String] = []
    var didFetchedData: (() -> ())?
    var firestore = Firestore.firestore()
    
    func fetchData() {
        firestore.collection("Data").getDocuments { getData, error in
            if error == nil && getData != nil{
                for document in getData!.documents {
                    let newDocument = document.data().first
                    if let value = newDocument?.value as? String {
                        self.dataArray.append(value)
                    }
                }
                self.didFetchedData?()
            }
        }
    }
    func postData(data: String) {
        firestore.collection("Data").addDocument(data: ["Text" : data as Any])
    }
}
