//
//  GetTodos.swift
//  CaseApp
//
//  Created by Emir Alkal on 17.07.2022.
//

import Foundation

class GetTodos: ObservableObject {
    @Published var data = [ToDoModel]()
    @Published var noData = false
    
    init() {
        NetworkManager().getTodos { todoModel in
            self.data = todoModel
        }
    }
}
