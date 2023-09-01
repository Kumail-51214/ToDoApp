//
//  Struct.swift
//  ToDoApp
//
//  Created by Muhammad Kumail on 8/31/23.
//

import Foundation

struct MyToDoModel {
    init(todo: String, todoID: String) {
        self.todo = todo
        self.todoID = todoID
    }
    
    var todo: String
    var todoID: String
}
