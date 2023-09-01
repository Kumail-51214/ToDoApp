//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Muhammad Kumail on 8/28/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewModel {
    
    var todoArray: [MyToDoModel] = []
    var didFetchedData: (() -> ())?
    var firestore = Firestore.firestore()
    
    func postData(todo: String, todoID: String) {
        firestore.collection("Data").document(todoID).setData(["Text" : todo as Any])
        
    }
    func fetchData() {
        firestore.collection("Data").getDocuments { [self] getData, error in
            if error == nil && getData != nil{
                for document in getData!.documents {
                    var todoItem:MyToDoModel = .init(todo: "", todoID: "")
                    todoItem.todoID = document.documentID
                    print(todoItem.todoID)
                    let newDocument = document.data().first
                    if let value = newDocument?.value as? String {
                        todoItem.todo = value
                        self.todoArray.append(todoItem)
                        
                    }
                }
                self.didFetchedData?()
            }
        }
    }
    func deleteData(todoId: String) {
        firestore.collection("Data").document(todoId).delete(){ err in
            print(self.todoArray)
            if let error = err {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
                
            }
        }
    }
}
